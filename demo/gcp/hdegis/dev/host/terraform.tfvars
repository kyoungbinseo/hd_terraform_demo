vpc_name = "vpc-dev-hdegis-host-int-shared"

subnets = {
  sbn-dev-hdegis-host-int-shared = {
    cidr     = "10.23.28.32/27"
    purpose  = "PRIVATE"
    desc     = "개발 자원 생성 서브넷"
  },
  sbn-dev-hdegis-host-int-lb = {
    cidr     = "10.23.38.128/26"
    purpose  = "REGIONAL_MANAGED_PROXY"
    desc     = "개발 LB용 프록시 서브넷"
    role     = "ACTIVE"  # 프록시 서브넷의 역할 지정
  }
}

peering_name = "peer-dev-hdegis-prd-hdermd"
project      = "pjt-dev-hdegis-host-454206"
hdermd_host_prd_project = "pjt-prd-hdermd-host"
hdermd_host_prd_project_id  = "projects/pjt-prd-hdermd-host/global/networks/vpc-prd-hdermd-host-int-shared"
region       = "asia-northeast3"