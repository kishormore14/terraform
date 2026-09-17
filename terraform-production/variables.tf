variable "aws_region" {
  description = "AWS Region to deploy resources into"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project identifier used for naming resources"
  type        = string
  default     = "kishor-app"
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-098f18a6382fb4b2d"
}
