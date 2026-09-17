packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon_linux_nginx" {
  ami_name      = "golden-nginx-v1.0.0-{{timestamp}}"
  instance_type = "t3.micro"
  region        = "us-east-1"

  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.*-x86_64"
      virtualization-type = "hvm"
    }
    owners      = ["137112412989"] # Amazon
    most_recent = true
  }

  ssh_username = "ec2-user"
}

build {
  name    = "build-nginx-ami"
  sources = ["source.amazon-ebs.amazon_linux_nginx"]

  provisioner "shell" {
    inline = [
      "sudo dnf install -y nginx",
      "sudo systemctl enable nginx"
    ]
  }
}
