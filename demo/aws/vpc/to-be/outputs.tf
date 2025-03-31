output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.ksoe_demo.id
}

output "subnet_id_web01" {
  description = "생성된 Public Subnet ID"
  value       = aws_subnet.ksoe_demo_sbn_web01.id
}

output "subnet_id_web02" {
  description = "생성된 Private Subnet ID"
  value       = aws_subnet.ksoe_demo_sbn_web02.id
}
