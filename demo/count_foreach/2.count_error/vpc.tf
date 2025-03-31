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

resource "aws_instance" "server" {
  ami           = "ami-0e8bd0820b6e1360b"
  instance_type = "t4g.nano"
  subnet_id = aws_subnet.public[1].id
  # index 접근 방법 오류 해결 코드
  # subnet_id = aws_subnet.public[index(aws_subnet.public.*.cidr_block, "10.220.11.64/26")].id
  tags = {
    Name = "count_error_demo"
  }
}