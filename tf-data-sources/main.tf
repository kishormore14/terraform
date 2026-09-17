


terraform {
  required_providers {
    aws={
        source  = "hashicorp/aws"
        version = "6.64.0"
    }
  }
}
provider "aws"{
    region = "ap-south-1"
}
data "aws_ami" "amz-linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}
output "aws_ami" {
  value = data.aws_ami.amz-linux.id
}

resource "aws_instance" "nginxt" {
  ami = data.aws_ami.amz-linux.id
  instance_type = "t3.micro"
  tags = {
    Name = "Nginx-Server"
  }
}