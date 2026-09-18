provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

output "zone" {
  value = data.aws_availability_zones.available.names
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.2"
  name = "test-vpc"
  cidr = "10.0.0.0/16"
  azs = data.aws_availability_zones.available.names
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.1.0/24"]

  tags = {
    Name = "test-vpc"
  }
}