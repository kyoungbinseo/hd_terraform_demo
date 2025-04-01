resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_resources" {
  for_each = var.subnets

  name          = each.key
  ip_cidr_range = each.value.cidr
  purpose       = each.value.purpose
  description   = each.value.desc
  network       = google_compute_network.vpc.id
  
  # REGIONAL_MANAGED_PROXY 용도가 아닌 서브넷에는 private_ip_google_access를 설정
  # -> private_ip_google_access: 서브넷의 목적(purpose)이 "REGIONAL_MANAGED_PROXY"가 아니면 
  # -> true로 설정되어 GCP의 Google API에 대한 프라이빗 IP 액세스를 허용. 그렇지 않으면 null로 설정.
  private_ip_google_access = each.value.purpose != "REGIONAL_MANAGED_PROXY" ? true : null
  
  # role 값이 null이 아닌 경우에만 설정
  role = each.value.role
}

## Peering
# Create peering from pjt-dev-hdegis-host to pjt-prd-hdermd-host
resource "google_compute_network_peering" "peer_dev_hdegis_to_prd_hdermd" {
  name         = var.peering_name
  network      = google_compute_network.vpc.id
  peer_network = var.hdermd_host_prd_project_id
  
  # Optional settings
  export_custom_routes = true
  import_custom_routes = true
  
  export_subnet_routes_with_public_ip = false
  import_subnet_routes_with_public_ip = false
}