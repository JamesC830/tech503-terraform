# Make security groups for the app and database

provider "aws" {
  # which region we want to use
  region = var.base_ubuntu_22_region

  # When we do teraform init it will download all the required dependancies for the provider stated
}

# Create app security group
resource "aws_security_group" "app_sg" {
  name        = "tech503-james-app-sg-terraform"

# Add inbound traffic ports
# Allow port a (number not specified for security)
  ingress {
    description = "Allow HTTP"
    from_port   = var.base_app_sg_allowed_port_a
    to_port     = var.base_app_sg_allowed_port_a
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow port b
  ingress {
    description = "Allow SSH"
    from_port   = var.base_app_sg_allowed_port_b
    to_port     = var.base_app_sg_allowed_port_b
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow port c
  ingress {
    description = "Allow reverse proxy"
    from_port   = var.base_app_sg_allowed_port_c
    to_port     = var.base_app_sg_allowed_port_c
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Add outbound traffic rules
# Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech503-james-app-sg-terraform"
  }
}

# Create database security group
resource "aws_security_group" "db_sg" {
  name        = "tech503-james-db-sg-terraform"

# Add inbound traffic ports
# Allow port d
  ingress {
    description = "Allow HTTP"
    from_port   = var.base_app_sg_allowed_port_d
    to_port     = var.base_app_sg_allowed_port_d
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow port b
  ingress {
    description = "Allow SSH"
    from_port   = var.base_app_sg_allowed_port_b
    to_port     = var.base_app_sg_allowed_port_b
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Add outbound traffic rules
# Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech503-james-db-sg-terraform"
  }
}