# Artifact Registry API 활성화
resource "google_project_service" "artifact_registry" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container_scanning_api" {
  service = "containerscanning.googleapis.com"
  disable_on_destroy = false
}
##--------------------------------------------------------
# disable_on_destroy = false 옵션은 terraform destroy후에도 api 비활성화를 막는 코드
# terraform으로 api 활성화하여도 다른 리소스에서 해당 api를 사용할 수 있기에
# terraform 코드를 삭제하여도 api는 활성화 되도록 처리


# Artifact Registry
resource "google_artifact_registry_repository" "repositories" {
  # var.repositories 변수에 있는 여러 개의 레포지토리를 반복문을 사용하여 동적으로 생성
  # { repo.name => repo } 형태의 맵을 만들어 repo.name을 키로 사용
  # map 형태 변환 후 each.value를 통해 각 요소에 접근
  for_each = { for repo in var.repositories : repo.name => repo }

  repository_id = each.value.name
  description   = each.value.description
  format        = each.value.format
  location      = each.value.location

  depends_on = [google_project_service.artifact_registry]
}

##--------------------------------------------------------
# var.repositories와 for repo in var.repositories : repo.name => repo의 차이
# -> for_each에 들어가는 데이터는 반드시 맵(Map) 형태
# -> var.repositories는 리스트 형태로 정의했으므로 for 표현식을 사용해 맵으로 변환
# -> 만약 variables에서 map으로 정의한다면 for_each = var.repositories 가능


