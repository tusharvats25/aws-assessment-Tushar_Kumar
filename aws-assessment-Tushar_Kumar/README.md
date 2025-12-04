# AWS Assessment - Tushar_Kumar

This repository contains Terraform IAM code and scripts for the 5 tasks requested:
- Q1_VPC_Networking
- Q2_EC2_StaticWebsite
- Q3_HA_ASG_ALB
- Q4_Billing_Alarms
- Q5_Architecture_Diagram

Each folder contains a README with usage instructions. Replace variables with your real IDs (VPC, subnet ids) before applying.


Networking-Subnetting-AWS-VPC-Setup-Task/
│
├── 01_VPC_Setup/
│   ├── main.tf
│   ├── README.md
│   └── screenshots/
│
├── 02_EC2_StaticWebsite/
│   ├── main.tf
│   ├── install_nginx.sh
│   ├── README.md
│   └── screenshots/
│
├── 03_HighAvailability_ASG/
│   ├── main.tf
│   ├── user_data.sh
│   ├── README.md
│   └── screenshots/
│
├── 04_Billing_Alerts/
│   ├── README.md
│   └── screenshots/
│
└── 05_ArchitectureDiagram/
    ├── architecture.png
    └── README.md


🔧 Prerequisites

Install the following before running Terraform:

✅ 1. Install Terraform
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform -v

✅ 2. Install AWS CLI
brew install awscli
aws --version

✅ 3. Configure AWS credentials:
aws configure


Enter:

AWS Access Key ID

AWS Secret Access Key

Default region → ap-south-1

Output → json

Verify:

aws sts get-caller-identity

✅ 4. Install VS Code + Terraform extension
🚀 How to Run Each Task (Step-by-Step)
🟩 Task 1 — VPC, Subnets, IGW, NAT Gateway

Folder: Q1_VPC_Networking

Run commands
cd Q1_VPC_Networking
terraform init
terraform apply -var="name_prefix=Tushar_Kumar" -var="aws_region=ap-south-1"

What this creates

1 VPC → 10.0.0.0/16

2 Public Subnets (10.0.1.0/24, 10.0.2.0/24)

2 Private Subnets (10.0.11.0/24, 10.0.12.0/24)

NAT Gateway + Elastic IP

Internet Gateway

Route Tables

Screenshots required

Upload to: Q1_VPC_Networking/screenshots/

VPC Page

Subnets Page

Public Route Table

Private Route Table

NAT Gateway

Internet Gateway

Destroy resources after screenshots
terraform destroy -var="name_prefix=Tushar_Kumar" -var="aws_region=ap-south-1"

🟦 Task 2 — EC2 Static Website Hosting (Nginx)

Folder: Q2_EC2_StaticWebsite

Before running

You need values from Task 1:

VPC ID

Public Subnet ID

Run commands
cd Q2_EC2_StaticWebsite
terraform init
terraform apply \
  -var="name_prefix=Tushar_Kumar" \
  -var="vpc_id=vpc-xxxxxxxx" \
  -var="public_subnet_id=subnet-xxxxxxx"

What this creates

A t2.micro EC2 instance

Nginx automatically installed via install_nginx.sh

Resume webpage hosted on /usr/share/nginx/html/index.html

Screenshots required

Upload to: Q2_EC2_StaticWebsite/screenshots/

EC2 Instance Details

Security Group Rules

Website visible in browser → http://<EC2-PUBLIC-IP>

Destroy resources
terraform destroy ...

🟨 Task 3 — High Availability: ALB + ASG + Private EC2

Folder: Q3_HA_ASG_ALB

Before running

Use:

VPC ID

Public Subnets (2)

Private Subnets (2)

Run commands
cd Q3_HA_ASG_ALB
terraform init
terraform apply \
  -var="name_prefix=Tushar_Kumar" \
  -var="vpc_id=vpc-xxxx" \
  -var='public_subnets=["subnet-a","subnet-b"]' \
  -var='private_subnets=["subnet-c","subnet-d"]'

What this creates

Internet-facing Application Load Balancer

Auto Scaling Group (HA across AZs)

2–4 Nginx EC2 instances in private subnets

Traffic flow:
User → ALB → Target Group → Private EC2

Screenshots required

Upload to: Q3_HA_ASG_ALB/screenshots/

ALB Config

Target Group

Auto Scaling Group

EC2 instances launched by ASG

Destroy
terraform destroy

🟥 Task 4 — Billing & Free Tier Alerts

Folder: Q4_Billing_Alarms

Run command
cd Q4_Billing_Alarms
terraform init
terraform apply

Then enable Free Tier usage alerts manually:

AWS Console → Billing → Free Tier → Enable

Screenshots required

Upload to: Q4_Billing_Alarms/screenshots/

CloudWatch Billing Alarm

Free Tier Alerts Page

🟪 Task 5 — AWS Architecture Diagram (draw.io)

Folder: Q5_Architecture_Diagram

Steps

Open diagram.drawio in https://app.diagrams.net

Design architecture including:

ALB

Auto Scaling Group

Public + Private Subnets

RDS / Aurora

ElastiCache

Security Groups, NACLs

CloudWatch monitoring

Export as PNG and place it inside folder.

Files to upload

diagram.drawio

diagram.png or diagram.pdf

📝 How to Upload Screenshots

Inside each task folder, place your screenshots under:

screenshots/


Example path:

Q1_VPC_Networking/screenshots/VPC.png


Then commit and push:

git add .
git commit -m "Added screenshots for task 1"
git push origin main

🧩 How to Push Code to GitHub (Full Steps)
git init
git add .
git commit -m "AWS Assessment by Tushar Kumar"
git branch -M main
git remote add origin https://github.com/<username>/<repo>.git
git push -u origin main

⚠️ Important Notes
✅ Always use the prefix:
Tushar_Kumar_

⚠️ Destroy NAT Gateway ASAP

NAT Gateway is NOT free tier.

⚠️ Check AWS region

Use: ap-south-1

⚠️ Keep IAM keys safe

Never upload IAM keys to GitHub.
