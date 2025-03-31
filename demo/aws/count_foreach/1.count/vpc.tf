resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo count vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.demo.id
  cidr_block        = var.public_subnets[count.index].cidr
  availability_zone = var.public_subnets[count.index].az

  tags = var.public_subnets[count.index].tags
}