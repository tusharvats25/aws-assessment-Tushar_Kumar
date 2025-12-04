terraform {
  required_providers { aws = { source = "hashicorp/aws" } }
}

provider "aws" { region = var.aws_region }

variable "aws_region" { default = "ap-south-1" }
variable "name_prefix" { default = "Tushar_Kumar" }

# Billing alarms require region us-east-1 for some APIs; user may set provider alias if needed.
resource "aws_cloudwatch_metric_alarm" "billing_alert" {
  alarm_name = "${var.name_prefix}_billing_alert_inr_100"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  metric_name = "EstimatedCharges"
  namespace = "AWS/Billing"
  period = 21600
  statistic = "Maximum"
  threshold = 100.0
  alarm_description = "Alert when estimated charges >= INR 100"
  dimensions = { Currency = "INR" }
}

# Free tier usage alerts are usually configured from Billing console (no direct CF metric). See README for manual steps.
