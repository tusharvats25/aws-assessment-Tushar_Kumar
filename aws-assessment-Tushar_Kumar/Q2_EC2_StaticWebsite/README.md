# Q2 - EC2 Static Website Hosting

Usage:
terraform init
terraform apply -var="name_prefix=Tushar_Kumar" -var="vpc_id=vpc-xxxx" -var="public_subnet_id=subnet-xxxx"

The module creates a t2.micro, installs Nginx (via user_data), and serves a basic static page.
Take screenshots: EC2 instance, Security Group, Browser showing public IP.
