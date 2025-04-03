vm_configurations = [
  {
    name = "prod-server-01"
    # size     = "Standard_B2s"
    username = "admin123"
    password = "P@ssw0rd123567adsA!"
    tags = {
      company = "ksoe"
      team    = "클라우드추진팀"
      manage  = "최규현"
      code    = "PRJ-2025"
      os      = "rhel8.5"
      purpose = "개발 vm 테스트"
    }
  },
    {
      name     = "prod-server-02"
    size     = "Standard_D4s_v3"
      username = "prodadmin"
      password = "SecureDB#456789"
      tags = {
        company = "ksoe"
        team    = "클라우드추진팀"
        manage  = "최규현"
        code    = "PRJ-2025-2"
        os      = "rhel7.6"
        purpose = "개발 test create vm"
      }
    }
    # ,
  #   {
  #     name     = "dev-server-03"
  #     # size     = "Standard_B2s"
  #     username = "t1t0"
  #     password = "SecureDB#456789"
  #     tags = {
  #       company = "ksoe"
  #       team    = "클라우드추진팀"
  #       manage  = "최규현"
  #       code    = "test3"
  #       os      = "rhel7.6"
  #       purpose = "개발 VM 테스트트"
  #     }
  #   }
]

