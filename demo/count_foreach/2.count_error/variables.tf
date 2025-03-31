variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
}