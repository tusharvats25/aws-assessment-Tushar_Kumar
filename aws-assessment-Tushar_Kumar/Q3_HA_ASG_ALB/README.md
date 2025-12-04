# Q3 - High Availability + Auto Scaling (ALB + ASG)

Usage:
terraform init
terraform apply -var="name_prefix=Tushar_Kumar" -var="vpc_id=vpc-xxxx" -var='public_subnets=["subnet-a","subnet-b"]' -var='private_subnets=["subnet-c","subnet-d"]'

Outputs:
- ALB DNS name (alb_dns)
Take screenshots: ALB configuration, Target Group, ASG, EC2 instances created by ASG.
