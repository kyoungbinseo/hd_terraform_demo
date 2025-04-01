

variable "project" {
  type        = string
  description = "Project ID for development HDEGIS app"
}

variable "region" {
  type        = string
}

## Service Account

variable "service_account_collect" {
  description = "수집서버 서비스 계정 정보"
  type = object({
    account_id   = string
    display_name = string
    description  = string
    roles        = list(string)
  })
}

variable "service_account_runjob" {
  description = "Cloud Run Job Backend 서비스 계정 정보"
  type = object({
    account_id   = string
    display_name = string
    description  = string
    roles        = list(string)
  })
}