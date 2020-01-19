
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
}

# Public
resource "aws_subnet" "public_subnet" {
  cidr_block = var.public_cidr_range
  vpc_id = aws_vpc.vpc.id

  availability_zone_id = var.subnet_availability_zone
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "public_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_access.id
}

resource "aws_internet_gateway" "internet_access" {
  vpc_id = aws_vpc.vpc.id

}

# Private
resource "aws_subnet" "private_subnet" {
  cidr_block = var.private_cidr_range
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private_route_table.id
  subnet_id = aws_subnet.private_subnet.id
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat_gateway.id
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet.id
}
