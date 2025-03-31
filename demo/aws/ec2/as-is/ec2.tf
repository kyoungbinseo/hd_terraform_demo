resource "aws_eip" "elasticip" {
    instance = aws_instance.demo_ec2_asis.id
    tags = {
      Name = "ksoe_eip_demo_asis"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.demo_ec2_asis.id
  allocation_id = aws_eip.elasticip.id
}

resource "aws_instance" "demo_ec2_asis" {
  ami                           = "ami-0e1234567890abcdef0"
  instance_type                 = "t4g.micro"
  vpc_security_group_ids        = ["sg-0fcd631775c60e783"]
  subnet_id                     = "subnet-0360ef1f02e6e0173"
  associate_public_ip_address   = true


  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "ksoe_ec2_demo_asis"
  }

}