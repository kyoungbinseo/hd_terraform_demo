
# create for terraform backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82.2"
    }
  }
  backend s3 {
    bucket         = "ksoe-demo-s3-terraform" # S3 버킷 이름
    key            = "ec2/as-is/terraform.tfstate" # tfstate 저장 경로
    region         = "ap-northeast-2"
    encrypt        = true
  }
}

provider "aws" {
  region    = "ap-northeast-2"
  default_tags {
    tags = {
      environment       = "demo"
      terraform_managed = "true"
    }
  }
}