# output "role_arn" {
#   value = aws_iam_role.ec2_role.arn
# }

output "sg_id" {
  value = aws_security_group.demo.id
}

output "ec2_id" {
  value = aws_instance.demo_ec2_asis.id
}

