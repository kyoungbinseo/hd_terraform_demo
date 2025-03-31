# 목표
- count를 사용하는 경우, 리소스 교체가 발생하는 상황을 재현
- 상황 재현 방법
```
1. terraform apply
2. terraform.tfvars파일에서 subnets값 첫번째 요소를 주석처리 (리소스 삭제 가정)
3. terraform plan의 결과를 확인. EC2 instance는 replaced표시 확인.
```


✅ 상황
Terraform에서 count 를 써서 여러 개의 리소스를 반복 생성할 때,

```hcl
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  ...
}
```
- 생성된 서브넷들은 aws_subnet.public[0].id, aws_subnet.public[1].id 처럼 index 기반으로 접근
- 문제는 서브넷 배열의 순서가 바뀌거나, 중간에 삭제/추가되면 index가 꼬이면서 관련된 리소스(예: EC2)까지 같이 삭제/재생성되는 문제가 발생

✅ 기존 코드의 문제 (index 접근 방식)
```hcl
subnet_id = aws_subnet.public[1].id
```
- 이렇게 쓰면 단순히 두 번째 서브넷을 참조
- 만약 aws_subnet.public 의 순서가 바뀌면? → 의도하지 않은 다른 서브넷을 참조하게 됨.
- 심하면 서브넷이 바뀌면서 EC2가 삭제 & 재생성되는 일이 발생.

✅  코드 변경 (index() 함수로 매칭 방식)
```hcl
# index 접근 방법 오류 해결 코드
subnet_id = aws_subnet.public[index(aws_subnet.public.*.cidr_block, "10.220.11.64/26")].id
```
🔑  해석:

➡️ `aws_subnet.public.*.cidr_block` :
  - 모든 서브넷의 cidr_block 값을 리스트로 가져옴.
  - 예: ["10.220.11.0/26", "10.220.11.64/26"]

➡️ `index(..., "10.220.11.64/26")` :
  - 위 리스트에서 "10.220.11.64/26" 가 몇 번째인지 찾아서 index 번호 반환.
  - 예: 1 (두 번째 위치)

➡️ `aws_subnet.public[<index>].id` :
  - 찾은 인덱스를 이용해 해당 서브넷의 id 참조.
  - 즉, CIDR 대역을 기준으로 정확히 일치하는 서브넷을 찾아서 할당하는 방식.

