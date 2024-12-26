resource "aws_key_pair" "dove-key" {
  key_name   = "dove-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKcezH/3TulNfmqFvR9W9TCto8biniM3mqlpBAqkzksS STIC-Martin@STIC-Martin"
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7fv5kmwBhp8zd62HESVybnvMYBiu11Oq6VeMkD7bqT STIC-Martin@STIC-Martin"
}