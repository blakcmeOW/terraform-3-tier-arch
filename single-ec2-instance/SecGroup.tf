resource "aws_security_group" "dove-sg" {
  name        = "dove-sg"
  description = "dove-sg"
  #vpc_id      = aws_vpc.main.id

  tags = {
    Name = "dove-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshfromMyIP" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "180.190.114.197/32"
  #cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv6" {
  security_group_id = aws_security_group.dove-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}