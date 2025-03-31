# VPC, Subnets 생성

- variables 변수를 사용하여 코드 최적화

## 1. VPC
📌  AS-IS 코드
```
resource "aws_vpc" "ksoe_demo" {
  cidr_block  = "10.220.10.0/24"

  tags = {
    Name = "ksoe_vpc_asis_demo"
  }
}
```
- `cidr_block  = "10.220.10.0/24"` 항목에 사용할 CIDR 대역 직접 입력

📌  TO-BE 코드
```
resource "aws_vpc" "ksoe_demo" {
  cidr_block   = var.vpc_cidr

  tags = {
    Name = "ksoe_vpc_tobe_demo"
  }
}

variable "vpc_cidr" {
  description = "VPC 대역"
  type        = string
  default     = "10.220.11.0/24"
}
```
- `cidr_block = var.vpc_cidr` 항목에 사용할 CIDR 대역 variable 변수에서 받아서 처리
- 변수들을 variables.tf 파일에서만 입력 받도록 설정
- ip 변경 시 variables 파일만 수정 가능


*Tag variables로 변환*
```
  tags = {
    Name = "${var.account_name}_vpc_${var.service_name}_${var.environment}"
  }


  variable "account_name" {
  type    = string
  default = "ksoe"
}

variable "service_name" {
  type    = string
  default = "demo"
}

variable "environment" {
  type    = string
  default = "to-be"
}
```
➡️ 코드 유연성을 높이기 위해 tag 값도 변수 처리

## 2.output 파일을 이용해 다른 리소스에서 호출 가능하도록 구성
```
output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.ksoe_demo.id
}

output "subnet_id_web01" {
  description = "생성된 Public Subnet ID"
  value       = aws_subnet.ksoe_demo_sbn_web01.id
}

output "subnet_id_web02" {
  description = "생성된 Private Subnet ID"
  value       = aws_subnet.ksoe_demo_sbn_web02.id
}

```
➡️ ec2 생성 시 해당 디렉토리에서 구성한 vpc cidr, subnet cidr을 변수로 받아 구성 예정