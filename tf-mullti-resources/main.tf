terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.64.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
locals {
  project="project-01"
}

resource "aws_vpc" "my_vpc" {
    cidr_block="10.0.0.0/16"
    tags={
      name="${local.project}-vpc"
    }
  
}

resource "aws_subnet" "main" {
    vpc_id=aws_vpc.my_vpc.id
    cidr_block="10.0.${count.index+1}.0/24"
    count = 2
    tags={
      name="${local.project}-subnet-${count.index+1}"
    }
}

resource "aws_instance" "main_instance"{
  for_each      = var.ec2_map
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key))
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_ids" {
  value = [for s in aws_subnet.main : s.id]
}