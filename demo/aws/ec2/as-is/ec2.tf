## public ec2 생성을 위해서 IGW 필요
# resource "aws_eip" "elasticip" {
#     instance = aws_instance.demo_ec2_asis.id
#     tags = {
#       Name = "ksoe_eip_demo_asis"
#   }
# }

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_instance.demo_ec2_asis.id
#   allocation_id = aws_eip.elasticip.id
# }

resource "aws_instance" "demo_ec2_asis" {
  ami                           = "ami-001690b4e6b46ab2c"
  instance_type                 = "t4g.micro"
  vpc_security_group_ids        = ["sg-08c8b8189e337436f"] # 수정 필요
  subnet_id                     = "subnet-00016ab070389c28e" 
  associate_public_ip_address   = false


  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "ksoe_ec2_demo_asis"
  }

}