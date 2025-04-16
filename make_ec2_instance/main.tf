# Where to make infrastucture (what cloud provider?)
provider "aws" {
  # which region we want to use
  region = "eu-west-1"

  # When we do teraform init it will download all the required dependancies for the provider stated
}

# Which service/resource
# Resource "Resource type" "Give it a name (within main.tf)"
resource "aws_instance" "app_instance" {

  # Which AMI to use
  ami = "ami-0f0c3baa60262d5b9"

  # What type of instance to use
  instance_type = "t2.micro"

  # Do we need a public IP
  associate_public_ip_address = true

  # Name the resource in AWS
  tags = {
    Name = "tech503-james-terraform-instance"
  }
}