resource "aws_vpc" "pearl-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "pearl-vpc"
  }
}


resource "aws_subnet" "pearl-pub-1a" {
  vpc_id     = aws_vpc.pearl-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pearl-pub-1a"
  }
}

resource "aws_subnet" "pearl-pub-1b" {
  vpc_id     = aws_vpc.pearl-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pearl-pub-1b"
  }
}

resource "aws_subnet" "pearl-pvt-1a" {
  vpc_id     = aws_vpc.pearl-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "pearl-pvt-1a"
  }
}

resource "aws_subnet" "pearl-pvt-1b" {
  vpc_id     = aws_vpc.pearl-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "pearl-pvt-1b"
  }
}


# IGW 
resource "aws_internet_gateway" "pearl-igw" {
  vpc_id = aws_vpc.pearl-vpc.id

  tags = {
    Name = "pearl-igw"
  }
}

# EIP
resource "aws_eip" "pearl-nat-eip" {
  vpc = true

  tags = {
    Name = "pearl-nat-EIP"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "pearl-nat" {
  allocation_id = aws_eip.pearl-nat-eip.id
  subnet_id     = aws_subnet.pearl-pub-1a.id

  tags = {
    Name = "pearl-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.pearl-igw]
}



#route table


# Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.pearl-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pearl-igw.id
  }
  tags = {
    Name = "pearl-publicRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "public_table_association_1a" {

  subnet_id      = aws_subnet.pearl-pub-1a.id
  route_table_id = aws_route_table.public_rt.id
  depends_on = [aws_internet_gateway.pearl-igw]
}

resource "aws_route_table_association" "public_table_association_1b" {

  subnet_id      = aws_subnet.pearl-pub-1b.id
  route_table_id = aws_route_table.public_rt.id
  depends_on = [aws_internet_gateway.pearl-igw]
}





# Route table: attach Nat gateway
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.pearl-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pearl-nat.id
  }
  tags = {
    Name = "pearl-privateRouteTable"
  }
}


# Route table association with private subnets


resource "aws_route_table_association" "private_table_association_1a" {

  subnet_id      = aws_subnet.pearl-pvt-1a.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_nat_gateway.pearl-nat]
}

resource "aws_route_table_association" "private_table_association_1b" {

  subnet_id      = aws_subnet.pearl-pvt-1b.id
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_nat_gateway.pearl-nat]
}
