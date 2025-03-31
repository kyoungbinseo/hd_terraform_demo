## tag를 위한 세팅
variable "account_name" {
  type    = string
}

variable "service_name" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "sg_name" {
  type    = string
}

variable "ec2_name" {
  type    = string
}

variable "ec2_type" {
  type    = string
}

## CIDR 세팅
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


locals {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    sub_web_az1_id = data.terraform_remote_state.vpc.outputs.subnet_id_web01
    sub_web_az2_id = data.terraform_remote_state.vpc.outputs.subnet_id_web02
}




