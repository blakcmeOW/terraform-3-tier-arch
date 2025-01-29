#terraform import aws_vpc.3-tier-project-test vpc-07bd573a43a044ebb
resource "aws_vpc" "three-tier-project-test" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "vpc_three-tier-project"
  }
}

#terraform import aws_internet_gateway.three-tier-project-test igw-0598db6e033e14880

resource "aws_internet_gateway" "three-tier-project-test" {
  vpc_id = aws_vpc.three-tier-project-test.id

  tags = {
    Name = "igw_three-tier-project"
  }
}

#terraform import aws_route_table.three-tier-proj-public-rt rtb-0b0125b3fe36008c9

resource "aws_route_table" "three-tier-proj-public-rt" {
  vpc_id = aws_vpc.three-tier-project-test.id

  tags = {
    Name = "pub-rt_three-tier-project"
  }
}

#terraform import aws_route_table.three-tier-proj-priv-rt rtb-0eba804139664acd0
resource "aws_route_table" "three-tier-proj-priv-rt" {
  vpc_id = aws_vpc.three-tier-project-test.id

  tags = {
    Name = "priv-rt_three-tier-proj"
  }
}