
variable "project" {
  type        = string
  description = "GCP 프로젝트 ID"
}

variable "region" {
  type        = string
}

## repositories 변수는 리스트 형태의 객체 집합
variable "repositories" {
  description = "Artifact Registry 레포지토리 목록"
  type = list(object({
    name        = string
    description = string
    format      = string
    location    = string
    mode        = string
  }))
}