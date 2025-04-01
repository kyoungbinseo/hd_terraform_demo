
output "vpc_id" {
  value = google_compute_network.vpc.id
}

## output 블록을 통해 서브넷 id 목록 추출
# google_compute_subnetwork 리소스에서 각 서브넷 id를 맵형태로 출력하는 용도
# 

# -> for 표현식을 통해 map 형태로 치환
output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = { for k, v in google_compute_subnetwork.subnet_resources : k => v.id }
}

output "subnet_ip_cidr_ranges" {
  description = "The IP CIDR ranges of the created subnets"
  value       = { for k, v in google_compute_subnetwork.subnet_resources : k => v.ip_cidr_range }
}

##--------------------------------------------------------

# for k, v in google_compute_subnetwork.subnet_resources:
# -> google_compute_subnetwork.subnet_resources는 for_each를 통해 생성된 서브넷 리소스를 의미
# -> 각 서브넷은 k(서브넷의 이름)과 v(서브넷의 리소스 정보)로 표현
# -> k는 각 서브넷의 이름 (즉, each.key), v는 해당 서브넷의 리소스 객체

# k => v.id : 
# ->  k(서브넷 이름)를 키(key)로, v.id(서브넷 리소스의 ID)를 값(value)설정하는 맵을 생성

