

variable "project" {
  type        = string
  description = "Project ID"
}

variable "hdermd_host_prd_project" {
  type        = string
  description = "Project ID for production HDERMD host"
}

variable "hdermd_host_prd_project_id" {
  type        = string
  description = "Project ID for production HDERMD host id"
}

variable "region" {
  type        = string
}


variable "vpc_name" {
  type        = string
  description = "VPC 네트워크 이름"
}

variable "peering_name" {
  type        = string
  description = "VPC Peering 네트워크 이름"
}

variable "subnets" {
  type = map(object({
    cidr    = string
    purpose = string
    desc    = string
    role    = optional(string, null) 
  }))
}
