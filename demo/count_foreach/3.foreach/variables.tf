variable "vpc_cidr" {
  type = string
}

# count에서의 list 타입을 map 형식으로 변경
variable "subnets" {
  type = map(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
}