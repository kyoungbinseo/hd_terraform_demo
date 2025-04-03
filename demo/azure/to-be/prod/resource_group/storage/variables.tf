variable "storages" {
  description = "생성할 스토리지 계정 및 컨테이너 목록"
  type = list(object({
    storage_account_name = string
    container_name       = string
  }))
}
