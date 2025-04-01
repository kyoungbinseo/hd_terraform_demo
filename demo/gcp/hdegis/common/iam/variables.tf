

variable "project" {
  type        = string
  description = "Project ID for development HDEGIS host"
}

variable "region" {
  type        = string
}

variable "folder_id" {
  description = "hdegis 폴더 ID"
  type        = string
}

variable "group_it_admin_arn" {
  description = "hdegis it admin group arn"
  type        = string
}
variable "group_developer_arn" {
  description = "hdegis aic developer group arn"
  type        = string
}
