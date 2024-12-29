//Web and App Server
resource "aws_instance" "web" {
  ami           = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.micro"
  #key_name = "web-app"
  key_name = element(["web-app", "app-web", "jenkins"], count.index)
  #subnet_id = aws_subnet.public[count.index].id
  subnet_id                   = element([aws_subnet.public[0].id,aws_subnet.public[1].id], count.index)
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count                       = 3

  tags = {
    #Name = "web_server"
    Name = element(["web_server", "app_server", "jenkins_server"], count.index)
  }

  root_block_device {
    volume_size           = 16    # Size of the volume in GB
    volume_type           = "gp2" # General Purpose SSD
    delete_on_termination = true
  }

  provisioner "file" {
    #source      = "web.sh"
    source      = element(["./bash-scripts/web.sh", "./bash-scripts/app.sh", "./bash-scripts/jenkins.sh"], count.index)
    destination = "/tmp/script.sh"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file(element(["./creds/web-app", "./creds/app-web", "./creds/jenkins"], count.index))
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
}

resource "aws_ebs_volume" "backup-logs" {
  #availability_zone = "ap-southeast-1a"
  availability_zone = aws_instance.web[count.index].availability_zone
  size              = 20
  type              = "gp2"
  count             = 3

  tags = {
    Name = "backup_logs"
  }
}

resource "aws_volume_attachment" "backup-logs-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.backup-logs[count.index].id
  instance_id = aws_instance.web[count.index].id
  count       = 3

  depends_on = [aws_instance.web]
}
/*
//Jenkins Server
resource "aws_instance" "jenkins" {
  ami           = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.micro"
  #key_name = "web-app"
  key_name = "jenkins"
  #subnet_id = aws_subnet.public[count.index].id
  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count                       = 1

  tags = {
    #Name = "web_server"
    Name = "jenkins_server"
  }

  root_block_device {
    volume_size           = 16    # Size of the volume in GB
    volume_type           = "gp2" # General Purpose SSD
    delete_on_termination = true
  }

  provisioner "file" {
    source      = "jenkins.sh"
    destination = "/tmp/script.sh"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("jenkins")
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
}
*/
/*
resource "aws_instance" "app" {
  ami = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.micro"
  key_name = "app-web"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "app_server"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  connection {
      type = "ssh"
      host = self.public_ip
      user = "ubuntu"
      private_key = file("web-app")
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
}
*/

//Database Server
/*
resource "aws_instance" "db" {
  ami           = "ami-06650ca7ed78ff6fa"
  instance_type = "t2.micro"
  key_name      = "db-app"
  subnet_id = aws_subnet.private.id
  #ubnet_id              = element([aws_subnet.private[0].id], count.index)
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]
  #count                  = 2
  associate_public_ip_address = true

  tags = {
    Name = "db_server"
  }

  provisioner "file" {
    source      = "db.sh"
    destination = "/tmp/db.sh"
  }

  connection {
    type        = "ssh"
    host        = self.private_ip
    user        = "ubuntu"
    private_key = file("db-app")
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/db.sh",
      "sudo /tmp/db.sh"
    ]
  }

  depends_on = [aws_instance.db]
}
*/

//Database Server with RDS
resource "aws_db_instance" "db-app" {
  allocated_storage   = 30
  storage_type        = "gp2"
  identifier          = "db-app"
  engine              = "mysql"
  engine_version      = "5.7.44"
  instance_class      = "db.t3.micro"
  username            = "admin"
  password            = "jvasccqte7yibxwyst2i2db"
  publicly_accessible = true
  skip_final_snapshot = true

  tags = {
    Name = "db_server"
  }
}