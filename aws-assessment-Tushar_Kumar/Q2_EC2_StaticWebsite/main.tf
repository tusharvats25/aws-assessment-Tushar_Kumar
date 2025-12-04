terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

provider "aws" { region = var.aws_region }

variable "name_prefix" { type = string, default = "Tushar_Kumar" }
variable "aws_region" { type = string, default = "ap-south-1" }
variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners = ["amazon"]
  filter { name = "name"; values = ["amzn2-ami-hvm-*-x86_64-gp2"] }
}

resource "aws_security_group" "web_sg" {
  name = "${var.name_prefix}_web_sg"
  description = "Allow HTTP and SSH"
  vpc_id = var.vpc_id

  ingress { from_port=22; to_port=22; protocol="tcp"; cidr_blocks=["0.0.0.0/0"] }
  ingress { from_port=80; to_port=80; protocol="tcp"; cidr_blocks=["0.0.0.0/0"] }
  egress { from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"] }

  tags = { Name = "${var.name_prefix}_web_sg" }
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amazon_linux2.id
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = file("${path.module}/install_nginx.sh")

  tags = { Name = "${var.name_prefix}_EC2_Web" }
}

output "public_ip" { value = aws_instance.web.public_ip }
