resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "dev_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_route_table" "dev_route" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_gateway.id
  }
}

resource "aws_route_table_association" "dev_association" {
  subnet_id      = aws_subnet.dev_public.id
  route_table_id = aws_route_table.dev_route.id
}

resource "aws_subnet" "dev_public" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Dev_Public"
  }
}

