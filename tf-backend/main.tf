
terraform {
  required_providers {
    aws={
        source  = "hashicorp/aws"
        version = "6.64.0"
    }
  }
  backend "s3" {
    bucket = "my-kishor-bucket-zdh2gign-123"
    key    = "dev/tf-backend/terraform.tfstate"
    region = "ap-south-1"
  }
}
provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami="ami-098f18a6382fb4b2d"
  instance_type="t3.micro"
  tags = {
    Name = "my-kishor-2"
  }
}