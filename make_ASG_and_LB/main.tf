provider "aws" {
  region = "eu-west-1"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnet" "az1" {
  availability_zone = "eu-west-1a"
  default_for_az    = true
}

data "aws_subnet" "az2" {
  availability_zone = "eu-west-1b"
  default_for_az    = true
}

data "aws_subnet" "az3" {
  availability_zone = "eu-west-1c"
  default_for_az    = true
}

locals {
  selected_subnets = [data.aws_subnet.az1.id, data.aws_subnet.az2.id, data.aws_subnet.az3.id]
}

# Optional: Define security group
resource "aws_security_group" "tech503-james-sg" {
  name        = "tech503-james-sg-terraform"
  description = "Allow HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Target group
resource "aws_lb_target_group" "tech503-james-tg-terraform" {
  name     = "tech503-james-tg-terraform"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Load Balancer
resource "aws_lb" "tech503-james-lb-terraform" {
  name               = "tech503-james-lb-terraform"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tech503-james-sg.id]
  subnets            = local.selected_subnets
}

# Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.tech503-james-lb-terraform.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tech503-james-tg-terraform.arn
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "tech503-james-asg-terraform" {
  name                      = "tech503-james-asg-terraform"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 2
  vpc_zone_identifier       = local.selected_subnets
  target_group_arns         = [aws_lb_target_group.tech503-james-tg-terraform.arn]
  health_check_type         = "ELB"
  launch_template {
    id      = "lt-02025b0b6a11b7e1f"
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "tech503-james-instance-terraform"
    propagate_at_launch = true
  }
}
