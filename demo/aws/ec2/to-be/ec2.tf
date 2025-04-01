# resource "aws_eip" "demo" {
#     instance = aws_instance.demo.id
#     tags = {
#       Name = "${var.account_name}_eip_${var.service_name}_${var.environment}"
#   }
# }

# resource "aws_eip_association" "demo" {
#   instance_id   = aws_instance.demo.id
#   allocation_id = aws_eip.demo.id
# }

resource "aws_instance" "demo" {
  ami                           = data.aws_ami.amazon_linux2.id
  instance_type                 = var.ec2_type
  vpc_security_group_ids        = [ aws_security_group.demo.id ]
  subnet_id                     = local.sub_web_az2_id
  associate_public_ip_address   = false


  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = var.ec2_name
  }

}