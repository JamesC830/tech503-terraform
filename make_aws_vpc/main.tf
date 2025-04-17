# Make a vpc

# Need to create: 
#VPC, 
#public subnet, 
#private subnet, 
#internet gateway, 
#route table, 
#security group
#app instance in public subnet

provider "aws" {
  # which region we want to use
  region = "eu-west-1"

  # When we do teraform init it will download all the required dependancies for the provider stated
}

# Create the VPC
resource "aws_vpc" "tech503-james-vpc-terraform" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tech503-james-vpc-terraform"
  }
}

# Create subnets
# Public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.tech503-james-vpc-terraform.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "public-subnet"
  }
}

# Private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.tech503-james-vpc-terraform.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-1a"
  tags = {
    Name = "private-subnet"
  }
}

# Internet gateway
resource "aws_internet_gateway" "tech503-james-2tier-vpc-ig-terraform" {
  vpc_id = aws_vpc.tech503-james-vpc-terraform.id
  tags = {
    Name = "tech503-james-2tier-vpc-ig-terraform"
  }
}

# Route table
resource "aws_route_table" "tech503-james-rt-terraform" {
  vpc_id = aws_vpc.tech503-james-vpc-terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech503-james-2tier-vpc-ig-terraform.id
  }

  tags = {
    Name = "tech503-james-rt-terraform"
  }
}

# Associate route table with public subnet
resource "aws_route_table_association" "tech503-james-rt-association-terraform" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.tech503-james-rt-terraform.id
}

# Security group for public subnet
resource "aws_security_group" "tech503-james-public-sg-terraform" {
  name        = "tech503-james-public-sg-terraform"
  description = "Allow HTTP, SSH, reverse proxy"
  vpc_id      = aws_vpc.tech503-james-vpc-terraform.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech503-james-public-sg-terraform"
  }
}

# Make an ec2 app instance within the public subnet
resource "aws_instance" "tech503-james-app-instance-terraform" {
  ami = "ami-0f0c3baa60262d5b9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id
  vpc_security_group_ids = [aws_security_group.tech503-james-public-sg-terraform.id]
  associate_public_ip_address = true
  key_name = var.aws_key_name
  tags = {
    Name = "tech503-james-app-instance-terraform"
  }
}