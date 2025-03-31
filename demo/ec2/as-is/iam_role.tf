# ## Create IAM Role 
# resource "aws_iam_role" "ec2_role" {
#   name = "${var.account_name}_iamr_${var.service_name}_${var.environment}_ec2"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#             Service = "ec2.amazonaws.com"
#                 # IAM Role 생성 시, EC2 Profile 역할로 사용됨을 지정
#         }
#         Action = "sts:AssumeRole"
#             # AdministratorAccess 권한이 존재 하더라도, AssumeRole로 접근 필수적
#       }
#     ]
#   })
# }

# # 위에서 생성한 IAM Role에 필요 정책 부착
# resource "aws_iam_role_policy_attachment" "attach_ssm_s3_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   role = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
#   role = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "attach_secret_mgr_rw_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
#   role = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
#   role = aws_iam_role.ec2_role.name
# }

# resource "aws_iam_instance_profile" "ec2_attachment" {
#   name = "EC2Role"
#   role = aws_iam_role.ec2_role.name
# }