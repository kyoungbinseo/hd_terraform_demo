# create vpc
resource "aws_vpc" "ksoe_demo" {
  cidr_block  = "10.220.10.0/24"

  tags = {
    Name = "ksoe_vpc_demo_asis"
    
  }
}

# create subnets 
resource "aws_subnet" "ksoe_demo_sbn_web01" {
  vpc_id            = aws_vpc.ksoe_demo.id
  cidr_block        = "10.220.10.0/25"  # /25로 잘라서 사용
  availability_zone = "ap-northeast-2a" 
  tags = {
    Name = "ksoe_sub_demo_asis_web_an2_az1"
  }
}

resource "aws_subnet" "ksoe_demo_sbn_web02" {
  vpc_id            = aws_vpc.ksoe_demo.id
  cidr_block        = "10.220.10.128/25"  # /25로 잘라서 사용
  availability_zone = "ap-northeast-2b" 
  tags = {
    Name = "ksoe_sub_demo_asis_web_an2_az2"
  }
}
