# AWS Provider 설정 및 기본 리소스 배포

## AWS ↔ Terraform 인증 방법

### **1️⃣AWS Credential 설정 확인**

`aws configure`로 설정하면 `~/.aws/credentials` 또는 `C:\Users\사용자명\.aws\credentials`에 아래와 같은 내용이 저장

```hcl

[default]
aws_access_key_id = AKIAXXXXXXXXXXXXXXXX
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
region = ap-northeast-2

```

Terraform이 이 설정을 자동으로 읽어옴

### **2️⃣ Terraform이 AWS Credential을 인식하는 로직**

Terraform의 `AWS Provider`는 내부적으로 **AWS SDK**를 사용하고, SDK는 아래 순서대로 Credential을 찾음

📌 **AWS Credential을 찾는 우선순위**

1. **환경 변수** (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`)
- 환경 변수에서 자격 증명이 설정되면 우선적으로 사용

2. **AWS Shared Credentials 파일** (`~/.aws/credentials` or `C:\Users\사용자명\.aws\credentials`)
- 자격 증명 파일에서 접근키와 비밀키가 설정되어 있으면 그 정보를 사용

3. **AWS Config 파일** (`~/.aws/config`)
- 이 파일에는 설정 파일과 프로파일 정보 기재. 
- ~/.aws/config 파일은 자격 증명이 아닌 설정 정보를 포함하지만, 만약 자격 증명이 다른 경로에서 제공되지 않으면 이 파일에서 프로파일을 사용

4. **IAM Role (EC2, Lambda, ECS 등에서 자동으로 부여됨)**
- EC2 인스턴스나 Lambda 함수 등의 IAM 역할이 부여된 리소스에서 실행되는 경우, 해당 IAM 역할에 설정된 권한을 자동으로 사용

즉, `aws configure`로 설정하면 **Terraform이 자동으로 Shared Credentials 파일에서 값을 읽어서 사용**