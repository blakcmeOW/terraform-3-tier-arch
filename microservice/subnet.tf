resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr[count.index]
  availability_zone = var.az[count.index]
  count             = 3

  tags = {
    #Name = "public-sub"\
    Name = element(["web_server", "app_server", "jenkins_server"], count.index)
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  #cidr_block        = var.cidr_private[count.index]
  #availability_zone = var.az[count.index]
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"
  #count = 1

  tags = {
    Name = "private-sub-db"
  }
}

data "aws_subnets" "sid" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }

  tags = {
    Tier = "Public"
  }
}