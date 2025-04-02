
# [0][1][2][3]

vpc_cidr = "10.220.11.0/24"
public_subnets = [
  {
    "cidr" = "10.220.11.0/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_a"
      Env  = "demo"
    }
  },
  # terraform apply이후 아래 64 대역을 주석하고 apply 하세요.
  # 그 이후 주석 해제 후 다시 apply
  {
    "cidr" = "10.220.11.64/26",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_b"
      Env  = "demo"
    }
  },
  {
    "cidr" = "10.220.11.128/26",
    "az"   = "ap-northeast-2a",
    tags = {
      Name = "ksoe_sub_demo_subnet_c"
      Env  = "demo"
    }
  },
  {
    "cidr" = "10.220.11.192/26",
    "az"   = "ap-northeast-2c",
    tags = {
      Name = "ksoe_sub_demo_subnet_d"
      Env  = "demo"
    }
  }
]
