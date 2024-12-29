resource "aws_key_pair" "web-app" {
  key_name   = "web-app"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKcezH/3TulNfmqFvR9W9TCto8biniM3mqlpBAqkzksS STIC-Martin@STIC-Martin"
}

resource "aws_key_pair" "app-web" {
  key_name   = "app-web"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSK8piHhQAwtyhIcn1d2xSXhOz01iCFfiLi5oC0dK9M STIC-Martin@STIC-Martin"
}

resource "aws_key_pair" "db-app" {
  key_name   = "jenkins"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETHnmszYeCq46zZLwF5WZG7OZY5ZxemUZ+Fs/huExOK STIC-Martin@STIC-Martin"
}

resource "aws_key_pair" "jenkins" {
  key_name   = "db-app"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7fv5kmwBhp8zd62HESVybnvMYBiu11Oq6VeMkD7bqT STIC-Martin@STIC-Martin"
}

/*
resource "aws_key_pair" "bastion" {
  key_name   = "bastion"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPP6Kx3GSQNhPfQ74u6b2BJ98iU8xoget0E40dyLbwJv STIC-Martin@STIC-Martin"
}
*/