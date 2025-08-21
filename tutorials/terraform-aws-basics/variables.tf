# Input Variables for AWS Infrastructure

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "demo-website"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ssh_cidr" {
  description = "CIDR block for SSH access"
  type        = string
  default     = "0.0.0.0/0"  # Change to your IP for security
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"  # Free tier eligible
}

variable "min_instances" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 3
}

variable "desired_instances" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 2
}