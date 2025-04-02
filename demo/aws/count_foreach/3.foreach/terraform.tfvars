vpc_cidr = "10.220.11.0/24"

subnets = {
  public-subnet-a = {
    "cidr" = "10.220.11.0/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_a"
      Environment = "demo"
    }
  },
  private-subnet-b = {
    "cidr" = "10.220.11.64/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_b"
      Environment = "demo"
    }
  },
  public-subnet-c = {
    "cidr" = "10.220.11.128/26",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_c"
      Environment = "demo"
    }
  },
  private-subnet-d = {
    "cidr" = "10.220.11.192/26",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_d"
      Environment = "demo"
    }
  },
}