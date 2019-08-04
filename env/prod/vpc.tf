resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "prod_gateway" {
  vpc_id = aws_vpc.prod_vpc.id
}

resource "aws_route_table" "prod_route" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gateway.id
  }
}

resource "aws_subnet" "prod_public" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Prod_Public"
  }
}

resource "aws_route_table_association" "prod_association" {
  subnet_id      = aws_subnet.prod_public.id
  route_table_id = aws_route_table.prod_route.id
}

