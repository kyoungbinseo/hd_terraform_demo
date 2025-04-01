# variables.tf (개선 사항)
variable "vm_configurations" {
  description = "VM 구성 (태그 필수)"
  type = map(object({
    name     = string
    size     = string
    username = string
    password = string
    tags = object({
      company = string
      team    = string
      manage  = string
      code    = string
      os      = string # OS 정보는 반드시 os_images 키와 일치
      purpose = string
    })
  }))
}

variable "os_images" {
  type        = map(string)
  description = "OS 이미지 매핑 (키는 tags.os와 일치)"
}
