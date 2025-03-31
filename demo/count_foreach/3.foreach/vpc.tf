resource "aws_vpc" "demo" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo count vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = var.subnets

  vpc_id            = aws_vpc.demo.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = each.value["tags"]
}

resource "aws_instance" "server" {
  ami           = "ami-0e8bd0820b6e1360b"
  instance_type = "t4g.nano"
  subnet_id = aws_subnet.public["private-subnet-b"].id

  tags = {
    Name = "foreach_demo"
  }
}