
project      = "pjt-dev-hdegis-app-454401"
region       = "asia-northeast3"


buckets = [
  {
    name        = "gcs-dev-hdegis-app-ispec"
    description = "개발 자동완성 input, output 저장 버킷"
    location    = "asia-northeast3"
    protection  = "Soft Delete"
  },
  {
    name        = "gcs-dev-hdegis-app-search"
    description = "개발 검색 input, output 저장 버킷"
    location    = "asia-northeast3"
    protection  = "Soft Delete"
  },
  {
    name        = "gcs-dev-hdegis-app-source"
    description = "개발 수집서버 소스코드 CI/CD 동기화 Staging 용도"
    location    = "asia-northeast3"
    protection  = "Soft Delete"
  }
]
