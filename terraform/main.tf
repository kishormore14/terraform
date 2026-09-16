
terraform {
  required_providers {
    aws={
        source  = "hashicorp/aws"
        version = "6.64.0"
    }
  }
}
provider "aws"{
    region = var.aws_region
}

resource "aws_instance" "myserver" {
  ami="ami-098f18a6382fb4b2d"
  instance_type="t3.micro"
  tags = {
    Name = "my-kishor-2"
  }
}