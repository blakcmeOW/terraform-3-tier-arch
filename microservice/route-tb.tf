resource "aws_route_table" "r-tb" {
  vpc_id = aws_vpc.main.id

  route = {
    cidr_block = "0.0.0.0/0"
    aws_internet_gateway = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "my-route"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.public[count.index].index
  route_table_id = aws_route_table.r-tb.id
  count = 2
}

resource "aws_default_route_table" "def_r-tb" {
    default_route_table_id = aws_vpc.main.default_route_table_id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw.id
    }

    tags = {
      Name = "def_r-tb"
    }
}