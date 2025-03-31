# 목표
- count변수를 for_each 타입으로 변경
- 리소스 추가, 삭제 시 **불필요한 재생성 없이 안전하게** 관리하기!


## ✅ 1. variable 선언 (list → map 전환)
```hcl
variable "subnets" {
  type = map(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
}
```

🔑 설명:
- 기존 `list(object(...))` 형태로 count를 사용하면 `순서(index)` 기반 관리.
- 순서가 바뀌거나 추가/삭제되면 index가 꼬여서 자원 재생성 이슈.
- `Map` 형태로 `키(key)`를 직접 정의하면 순서 상관없이 고유 식별자 기반으로 서브넷 관리 가능.
- 즉, `"public-subnet-a"`, `"private-subnet-b"` 같은 고유 이름을 key로 사용해 식별.


> 💡 Map으로 바꾸면 좋은 점:
> 
> - 사람이 읽기 쉬움.
> - 순서에 영향 안 받음.
> - 특정 subnet만 관리하거나 참조 쉽게 가능.


## ✅ 2. aws_subnet 자원 정의 (for_each 사용)
```hcl
resource "aws_subnet" "public" {
  for_each = var.subnets

  vpc_id            = aws_vpc.demo.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = each.value["tags"]
}
```

🔑 설명:
- `for_each = var.subnets` : subnets 변수(Map)를 순회하면서 key-value 쌍으로 리소스 생성.
- `each.key`: "public-subnet-a", "private-subnet-b"와 같은 고유 이름 (key).
- `each.value`: 해당 키의 내부 value (cidr, az, tags).

> 💡 중요 포인트:
> 
> - subnet 하나하나가 독립적인 자원으로 다뤄지고 이름(key)으로 참조 가능.
> - 예를 들어 나중에 특정 private subnet만 바꾸고 싶을 때도 용이.


## ✅ 3. EC2 인스턴스에서 subnet 참조
```hcl
resource "aws_instance" "server" {
  ami           = "ami-0e8bd0820b6e1360b"
  instance_type = "t4g.nano"
  subnet_id     = aws_subnet.public["private-subnet-b"].id

  tags = {
    Name = "foreach_demo"
  }
}
```

🔑 설명:
- `aws_subnet.public["private-subnet-b"].id` : Map key로 직접 서브넷 참조.
- 즉, 내가 쓰고 싶은 서브넷을 index가 아니라 **이름(key)**으로 정확히 명시적 지정.

> 💡 장점:
> 
> 특정 subnet에 대해 명확하게 접근 가능 (index가 아니라 이름).
> 예를 들어 public-subnet-a에 인스턴스를 넣고 싶으면 "public-subnet-a"로 변경만 하면 됨.


## ✅ 4. terraform.tfvars 예시
```hcl
subnets = {
  public-subnet-a = {
    "cidr" = "10.220.11.0/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_a"
      Environment = "demo"
    }
  },
  private-subnet-b = {
    "cidr" = "10.220.11.64/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_b"
      Environment = "demo"
    }
  }
}
```

🔑 설명:
- 고유 이름 `key` (public-subnet-a, private-subnet-b) 로 식별.
- 각 서브넷에 대한 세부 설정 포함 (cidr, az, tags).


➡️ 추가 리소스도 쉽게 추가 가능:
```hcl
new-subnet-e = {
  "cidr" = "10.220.12.0/26",
  "az"   = "ap-northeast-2b",
  tags = {
    Name = "ksoe_sub_demo_subnet_e"
    Environment = "demo"
  }
}
```

## ✅ 5. 기존 count 방식과 비교
| 항목                   | count 방식                                      | for_each 방식 (현재 방식)                          |
|----------------------|-------------------------------------------|---------------------------------------------|
| **식별 기준**          | index (0, 1, 2, ...)                              | 이름 (예: public-subnet-a, private-subnet-b)   |
| **추가/삭제 영향**    | 순서가 바뀌거나 중간 삭제 시 자원 재생성 위험         | 순서와 무관, key(이름) 기준으로 안전하게 관리     |
| **가독성/관리성**      | index로 관리하여 가독성 떨어짐                        | 이름 기반으로 가독성 및 관리 용이                  |
| **특정 리소스 참조**  | `aws_subnet.public[0].id` (index 기반)             | `aws_subnet.public["private-subnet-b"].id` (이름 기반) |



### 🚀  정리: 왜 for_each + map이 좋은가?
- 고유 이름 기반 관리 → 안전하고 명확
- 순서 꼬임으로 인한 자원 재생성 방지
- 특정 서브넷만 선택적 참조 가능
- 코드 확장성 (서브넷 추가/삭제 편리)

