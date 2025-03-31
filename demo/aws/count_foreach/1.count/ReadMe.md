## 1️⃣ 변수 (Variables) 정의 부분
```hcl
variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
}
```

✅ 의미:
- `vpc_cidr` : VPC의 CIDR 대역을 정의하는 문자열 변수.
- `public_subnets` :
    - 여러 개의 퍼블릭 서브넷을 담는 리스트.
    - 리스트 안의 각 서브넷은 object 타입 (복합 데이터) 으로 구성.
    - 각 오브젝트는 3가지 속성:
        - `cidr`: 서브넷의 CIDR 대역 (예: 10.220.11.0/25)
        - `az`: 가용영역 (예: ap-northeast-2a)
        - `tags`: key-value 형식의 태그 (예: Name = "ksoe_sub_demo_subnet_a")


## 2️⃣ 변수 값 (terraform.tfvars) 정의 부분
```hcl
vpc_cidr = "10.220.11.0/24"
public_subnets = [
  {
    "cidr" = "10.220.11.0/25",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_a"
      Env  = "demo"
    }
  },
  {
    "cidr" = "10.220.128.0/25",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_b"
      Env  = "demo"
    }
  }
]
```

✅ 의미:
- VPC 대역은 `10.220.11.0/24`
- 퍼블릭 서브넷 2개:
    - `10.220.11.0/25`, 서울(2a), 이름: `ksoe_sub_demo_subnet_a`, 환경: `demo`
    - `10.220.128.0/25`, 서울(2c), 이름: `ksoe_sub_demo_subnet_b`, 환경: `demo`


## 3️⃣ aws_subnet 리소스 부분
```hcl
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].az

  tags = var.public_subnets[count.index].tags
}
```

✅ 의미:
- *반복적으로(subnet 개수만큼)* 서브넷 생성.
- `count = length(var.public_subnets)` → `public_subnets` 리스트 길이만큼 생성 (2개).
- 각 인덱스에 따라 다음 값 할당:
    - `cidr_block`: 각 서브넷의 CIDR
    - `availability_zone`: 각 서브넷의 가용영역
    - `tags`: 각 서브넷의 태그 (Name, Env 등)