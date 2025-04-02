vpc_cidr = "10.220.11.0/24"
public_subnets = [
  {
    "cidr" = "10.220.11.0/25",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_a"
      Env  = "demo"
    }
  },
  {
    "cidr" = "10.220.128.0/25",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_b"
      Env  = "demo"
    }
  }
]