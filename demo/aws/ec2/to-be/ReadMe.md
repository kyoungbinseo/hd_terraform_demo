# Terraform Demo - EC2 to-be (최적화된 구조)

본 디렉토리는 **Terraform을 활용하여 AWS EC2 인스턴스를 코드로 배포**하는 예제로,  
**모듈화, 변수화, 코드 재사용성, 유지보수성**을 고려하여 **최적화된 방식**으로 구성되었습니다.  
AS-IS (하드코딩 기반 비효율적 방식) 대비 **가독성 향상, 관리 효율성**을 목표로 합니다.

---

## 📁 디렉토리 구조 및 파일 역할

```
.
├── data.tf             # 최신 AMI 등 동적 데이터 조회
├── ec2.tf  / sg.tf     # EC2 인스턴스 정의
├── outputs.tf          # 출력 변수 정의
├── main.tf             # AWS Provider 및 Backend 설정
├── terraform.tfvars    # 실제 사용할 변수 값 정의
└── variables.tf        # 변수 선언 및 기본값

```


| 파일명                | 설명                                                                          |
|---------------------|----------------------------------------------------------------------------|
| `main.tf`           | AWS Provider 및 Terraform 백엔드(S3) 설정                                      |
| `data.tf`           | 최신 AMI ID와 같은 동적 정보 조회                                              |
| `variables.tf`      | VPC, Subnet, EC2 등 주요 인프라 변수 정의 (재사용 가능한 변수 선언)              |
| `terraform.tfvars`  | 실제 인프라 생성 시 사용할 변수 값 할당 (환경별 값 관리 가능)                  |
| `locals.tf`         | 복잡한 변수 가공 및 중간 데이터 처리 (예: 다른 모듈에서 가져온 값 가공 등)       |
| `ec2.tf / sg.tf`    | EC2 인스턴스 생성 코드 (변수 기반으로 구성)                                    |
| `outputs.tf`        | EC2 생성 결과(예: public_ip, instance_id 등) 출력                              |

---


## 1. 최적화(변수화, 데이터 활용) 포인트

📌 전제 조건 (기존 정보)
- VPC, Subnet은 다른 프로젝트의 Terraform state에서 가져옴 (Remote State 사용).
- 따라서 data.terraform_remote_state로 VPC와 Subnet ID를 가져오는 방식.
- locals는 가져온 값을 변수처럼 쉽게 사용하기 위한 처리.

✅ data.tf
```
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ksoe-demo-s3-terraform" # 기존 VPC/Subnet을 관리하는 S3 버킷
    key    = "vpc/to-be/terraform.tfstate" # 기존 VPC/Subnet의 tfstate 경로
    region = "ap-northeast-2"
  }
}
```
- bucket, key, region 모두 VPC tfstate가 저장된 위치를 명확하게 설정.
- 즉, vpc/to-be/terraform.tfstate 경로에 저장된 VPC 및 서브넷 정보를 참조.

```
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```
- 하드코딩 대신 항상 최신 Amazon Linux 2 AMI 사용 가능
- 배포 시마다 최신 이미지 기반 인프라 생성

✅ locals (variables.tf 안)
```
locals {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    sub_web_az1_id = data.terraform_remote_state.vpc.outputs.subnet_id_web01
    sub_web_az2_id = data.terraform_remote_state.vpc.outputs.subnet_id_web02
}
```
- VPC, Subnet 등 다른 스테이트에서 공유된 자원 재사용
- 코드 재작성 필요 없이 유지보수 간소화

✅ outputs.tf
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
- 리소스 초기 구성 시 output 설정이 있어야 다른 리소스 구성시에도 활용 가능



# Variable 이용한 변수 처리
✅ variables.tf와 terraform.tfvars의 차이
|구분	|역할/용도	| 예시 |
|----|-----------|------|
|variables.tf	| 변수의 선언(정의), 변수의 타입, 기본값(optional), 설명 등 선언	| variable "vpc_cidr" { ... }|
|terraform.tfvars	| 선언된 변수의 **값(value)**을 실제 할당 (환경별로 다르게)	| vpc_cidr = "192.168.0.0/16"|

🔑 결론 (Best Practice)
variables.tf: 변수 선언만 담당 (하드코딩이 아니라 "형식과 설명" 역할)
terraform.tfvars (or other *.tfvars): 실제 값 주입 (환경별, 상황별 다른 값 가능)

## 예시
1. variables.tf (변수 선언, 형식, 설명)
```
variable "vpc_cidr" {
  description = "VPC 대역"
  type        = string
}

variable "web01_subnet_cidr" {
  description = "Public Subnet 대역"
  type        = string
}

variable "web02_subnet_cidr" {
  description = "Private Subnet 대역"
  type        = string
}
```
➡️ 여기에는 값을 적지 않음. 선언만!


2. terraform.tfvars (변수 값 입력)
```
vpc_cidr          = "10.220.11.0/24"
web01_subnet_cidr = "10.220.11.0/25"
web02_subnet_cidr = "10.220.11.128/25"
```
➡️ 환경별 값을 여기에 정의. 예를 들어 dev.tfvars, prd.tfvars 따로 만들 수도 있음.


3. main.tf (변수 사용)
```
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  ...
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.web01_subnet_cidr
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web02_subnet_cidr
  availability_zone = "ap-northeast-2b"
}
```

✅ 기대효과
- 하드코딩 제거로 환경 변화 시 유지보수 비용 절감
- 동적 데이터 활용으로 최신 인프라 자원 사용
- 구조화된 파일 분리로 역할별 코드 명확화
- 멀티 환경 대응 (예: 개발, 운영 환경 구분 가능)