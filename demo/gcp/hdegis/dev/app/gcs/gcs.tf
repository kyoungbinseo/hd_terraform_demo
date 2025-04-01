# GCS API 활성화
resource "google_project_service" "gcs" {
  project = var.project
  service = "storage.googleapis.com"
}

# GCS 버킷 생성
resource "google_storage_bucket" "buckets" {
  for_each    = { for bucket in var.buckets : bucket.name => bucket }
  name        = each.value.name
  location    = each.value.location
  storage_class = "STANDARD"

  labels = {
    description = each.value.name
  }

  # 공개 액세스 방지
  public_access_prevention = "enforced"

  # 균일한 액세스 제어
  uniform_bucket_level_access = true

  # 버저닝 비활성화
  versioning {
    enabled = false  
  }

  # GCP Storage API가 활성화 된 이후에 실행
  depends_on = [google_project_service.gcs] 
}
