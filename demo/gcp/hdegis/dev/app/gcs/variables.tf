
variable "project" {
  type        = string
  description = "Project ID for development HDEGIS app"
}

variable "region" {
  type        = string
}

## GCS
variable "buckets" {
  description = "GCS 버킷 목록"
  type = list(object({
    name        = string
    description = string
    location    = string
    protection  = string
  }))
}