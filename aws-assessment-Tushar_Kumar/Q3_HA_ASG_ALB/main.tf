terraform {
  required_providers { aws = { source = "hashicorp/aws" } }
}

provider "aws" { region = var.aws_region }

variable "name_prefix" { default = "Tushar_Kumar" }
variable "aws_region" { default = "ap-south-1" }
variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners = ["amazon"]
  filter { name = "name"; values = ["amzn2-ami-hvm-*-x86_64-gp2"] }
}

resource "aws_launch_template" "app" {
  name_prefix = "${var.name_prefix}_lt_"
  image_id = data.aws_ami.amazon_linux2.id
  instance_type = "t2.micro"
  user_data = filebase64("${path.module}/user_data.sh")
  network_interfaces {
    associate_public_ip_address = false
    security_groups = [aws_security_group.app_sg.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = { Name = "${var.name_prefix}_app_instance" }
  }
}

resource "aws_security_group" "alb_sg" {
  name = "${var.name_prefix}_alb_sg"
  description = "ALB SG"
  vpc_id = var.vpc_id
  ingress { from_port=80; to_port=80; protocol="tcp"; cidr_blocks=["0.0.0.0/0"] }
  egress { from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"] }
}

resource "aws_security_group" "app_sg" {
  name = "${var.name_prefix}_app_sg"
  description = "App SG - allow from ALB only"
  vpc_id = var.vpc_id
  ingress { from_port=80; to_port=80; protocol="tcp"; security_groups=[aws_security_group.alb_sg.id] }
  egress { from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"] }
}

resource "aws_lb" "alb" {
  name = "${var.name_prefix}_alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.public_subnets
}

resource "aws_lb_target_group" "tg" {
  name = "${var.name_prefix}_tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check { path = "/" }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.tg.arn }
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.name_prefix}_asg"
  desired_capacity = 2
  min_size = 2
  max_size = 4
  vpc_zone_identifier = var.private_subnets
  launch_template { id = aws_launch_template.app.id; version = "$Latest" }
  target_group_arns = [aws_lb_target_group.tg.arn]
  tag { key = "Name"; value = "${var.name_prefix}_asg_instance"; propagate_at_launch = true }
  health_check_type = "ELB"
  depends_on = [aws_lb_listener.http]
}

output "alb_dns" { value = aws_lb.alb.dns_name }
