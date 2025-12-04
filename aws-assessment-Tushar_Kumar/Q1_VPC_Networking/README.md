# Q1 - Networking & Subnetting (AWS VPC Setup)

This Terraform module creates:
- 1 VPC (10.0.0.0/16)
- 2 public subnets (10.0.1.0/24, 10.0.2.0/24)
- 2 private subnets (10.0.11.0/24, 10.0.12.0/24)
- Internet Gateway, NAT Gateway, Route tables

Usage:
1. Configure AWS credentials (aws configure)
2. cd Q1_VPC_Networking
3. terraform init
4. terraform apply -var="name_prefix=Tushar_Kumar" -var="aws_region=ap-south-1"

Take screenshots in the AWS Console for VPC, Subnets, Route Tables, NAT Gateway and IGW.
