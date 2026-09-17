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
resource "aws_instance" "webmyserver" {
  ami = var.ami-id
  instance_type = var.instance_type
  root_block_device {
    delete_on_termination = var.ec2_config.delete_on_termination
    volume_size = var.ec2_config.volume_size
    volume_type = var.ec2_config.volume_type
  }
  tags = merge(var.addinal_tags,
    {Name = local.Name}
  )
}