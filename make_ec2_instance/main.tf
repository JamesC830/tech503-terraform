# Where to make infrastucture (what cloud provider?)
provider "aws" {
  # which region we want to use
  region = var.base_ubuntu_22_region

  # When we do teraform init it will download all the required dependancies for the provider stated
}

# Which service/resource
# Resource "Resource type" "Give it a name (within main.tf)"
resource "aws_instance" "app_instance" {

  # Which AMI to use
  ami = var.base_ubuntu_22_ami_id

  # What type of instance to use
  instance_type = var.base_ubuntu_22_instance_type

  # Do we need a public IP
  associate_public_ip_address = var.base_ubuntu_22_public_ip_boolean

  # Name the resource in AWS
  tags = {
    Name = var.base_ubuntu_22_instance_name
  }
}