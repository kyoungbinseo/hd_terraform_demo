# create sg 
resource "aws_security_group" "demo" {
  name        = var.sg_name
  description = var.sg_name
  vpc_id      = local.vpc_id
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