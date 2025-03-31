# create sg 
resource "aws_security_group" "demo" {
  name        = "ksoe_sg_demo_asis"
  description = "sg for demo ec2"
  vpc_id      = "vpc-06ee3e3a57f2c5d42"
}

# attach rules
resource "aws_security_group_rule" "ingress_http" {
  security_group_id = aws_security_group.demo.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol       = "tcp"
}

resource "aws_security_group_rule" "ingress_https" {
  security_group_id = aws_security_group.demo.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  protocol       = "tcp"
}

resource "aws_security_group_rule" "egress_all" {
  security_group_id = aws_security_group.demo.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol       = "-1"
}