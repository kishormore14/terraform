variable "ami-id" {
  type        = string
  default     = "ami-098f18a6382fb4b2d"
  description = "AMI ID for EC2 Instance"
  validation {
    condition     = var.ami-id == "ami-098f18a6382fb4b2d"
    error_message = "Invalid AMI ID"
  }
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance Type for EC2 Instance"
  validation {
    condition     = var.instance_type == "t3.micro" || var.instance_type == "t3.small"
    error_message = "Invalid Instance Type"
  }
}

variable "ec2_config" {
  type = object({
    volume_size           = number
    volume_type           = string
    delete_on_termination = bool
  })
  default = {
    volume_size           = 8
    volume_type           = "gp3"
    delete_on_termination = true
  }
  description = "Root Block Device settings"
  validation {
    condition     = var.ec2_config.volume_size >= 8 && var.ec2_config.volume_size <= 30 && contains(["gp2", "gp3", "io1", "io2"], var.ec2_config.volume_type)
    error_message = "Root volume_size must be between 8 and 30 GB for Free Tier, and volume_type must be a valid SSD type (gp2, gp3, io1, io2)."
  }
}

variable "addinal_tags" {
  type        = map(string)#expect key value paire example  
  default     = {
    Name = "Nginx-Server2"
  }
  description = "Tags for EC2 Instance"
}
