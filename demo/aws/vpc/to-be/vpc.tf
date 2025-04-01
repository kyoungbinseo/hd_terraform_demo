# crate vpc
resource "aws_vpc" "ksoe_demo" {
  cidr_block   = var.vpc_cidr

  tags = {
    Name = "${var.account_name}_vpc_${var.service_name}_${var.environment}"
  }
}

# create subnets
resource "aws_subnet" "ksoe_demo_sbn_web01" {
  vpc_id            = aws_vpc.ksoe_demo.id
  cidr_block        = var.web01_subnet_cidr
  availability_zone = var.availability_zone_2a

  tags = {
    Name = "${var.account_name}_sbn_${var.service_name}_${var.environment}_web_an2_az1"
  }
}

resource "aws_subnet" "ksoe_demo_sbn_web02" {
  vpc_id            = aws_vpc.ksoe_demo.id
  cidr_block        = var.web02_subnet_cidr
  availability_zone = var.availability_zone_2b

  tags = {
    Name = "${var.account_name}_sbn_${var.service_name}_${var.environment}_web_an2_az2"
  }
}
