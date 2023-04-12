resource "aws_vpc" "lab_vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "lab-vpc"
  }
}

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-igw"
  }
}

resource "aws_subnet" "lab_subnet_1" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "lab-subnet-1"
  }
}

resource "aws_subnet" "lab_subnet_2" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "lab-subnet-2"
  }
}

resource "aws_route_table" "lab_route_table" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }

tags = {
  Name = "lab-route-table"
}
}

resource "aws_route_table_association" "lab_route_table_assoc_1" {
  subnet_id      = aws_subnet.lab_subnet_1.id
  route_table_id = aws_route_table.lab_route_table.id
}

resource "aws_route_table_association" "lab_route_table_assoc_2" {
  subnet_id      = aws_subnet.lab_subnet_2.id
  route_table_id = aws_route_table.lab_route_table.id
}