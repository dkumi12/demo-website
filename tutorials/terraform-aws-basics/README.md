# Terraform AWS Infrastructure Tutorial

This tutorial demonstrates how to create a complete AWS infrastructure using Terraform for a web application.

## What You'll Build

- VPC with public and private subnets
- Application Load Balancer
- EC2 instances in Auto Scaling Group
- RDS PostgreSQL database
- S3 bucket for static assets
- CloudWatch monitoring

## Prerequisites

- AWS CLI configured with credentials
- Terraform installed (v1.0+)
- Basic understanding of AWS services

## Step-by-Step Guide

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review the Plan
```bash
terraform plan
```

### 3. Deploy Infrastructure
```bash
terraform apply
```

### 4. Verify Deployment
```bash
# Check resources in AWS Console
# Test application endpoint
curl http://$(terraform output alb_dns_name)
```

### 5. Cleanup (Important!)
```bash
terraform destroy
```

## Cost Estimate
- **Development**: ~$50-100/month
- **Production**: ~$200-500/month
- **Free Tier**: Most resources eligible for 12 months

## Security Best Practices
- IAM roles with least privilege
- Security groups with minimal access
- Encrypted storage and transit
- VPC with private subnets for databases

## Troubleshooting
- Check AWS CLI credentials: `aws sts get-caller-identity`
- Verify Terraform state: `terraform state list`
- Check AWS quotas if resources fail to create