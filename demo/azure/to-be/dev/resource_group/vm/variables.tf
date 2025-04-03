# variables.tf (개선 사항)
variable "vm_configurations" {
  description = "VM 구성 (태그 필수)"
  type = list(object({
    name     = string
    size     = optional(string, "Standard_B2s")
    username = string
    password = string
    tags = object({
      company = string
      team    = string
      manage  = string
      code    = string
      os      = string
      purpose = string
    })
  }))
}
