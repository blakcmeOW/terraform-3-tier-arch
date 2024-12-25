resource "aws_instance" "web" {
  #ami =
  instance_type = "t2.micro"
  key_name = "web-app"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws.vpc_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "web_server"
  }

  provisioner "file" {
    source = "./web-app.pem"
    destination = "/home/ubuntu/web-app.pem"

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = "$(file(./web-app.pem))"
    }
  }
}

resource "aws_instance" "db" {
  #ami =
  instance_type = "t2.micro"
  key_name = "web-app"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws.vpc_security_group.allow_tls.id]

  tags = {
    Name = "db_server"
  }
}



