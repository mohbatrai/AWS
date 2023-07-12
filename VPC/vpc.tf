resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "TF-VPC-01"
  }
}

resource "aws_internet_gateway" "TF-igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "TF-igw"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.public-subnet-1-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.public-subnet-2-cidr}"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_route_table" "TF-public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.TF-igw.id
  }
 
   tags = {
    Name = "TF-public-rt"
  }
}

resource "aws_route_table_association" "public-subnet-1-rt-assign" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.TF-public-rt.id
}

resource "aws_route_table_association" "public-subnet-2-rt-assign" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.TF-public-rt.id
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-1-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 1| App Tier"
  }
}


resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-2-cidr}"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 2| App Tier"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-3-cidr}"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 3 | Database Tier"
  }
}

resource "aws_subnet" "private-subnet-4" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.private-subnet-4-cidr}"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 4 | Database Tier"
  }
}