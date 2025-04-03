data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "ksoe-demo-s3-terraform" # 기존 VPC/Subnet을 관리하는 S3 버킷
    key    = "vpc/to-be/terraform.tfstate" # 기존 VPC/Subnet의 tfstate 경로
    region = "ap-northeast-2"
  }
}
