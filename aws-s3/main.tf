
terraform {
  required_providers {
    aws={
        source  = "hashicorp/aws"
        version = "6.64.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "3.9.1"
    }
  }
}
provider "aws"{
    region = "ap-south-1"
}
resource "random_string" "bucket_name" {
  length  = 8
  special = false
}
resource "aws_s3_bucket" "demobucket" {
    bucket = "my-kishor-bucket-${lower(random_string.bucket_name.result)}-123"
    force_destroy = true
    tags = {
        Name = "my-kishor-bucket-abcde"
    }
}

resource "aws_s3_object" "demo_file" {
    bucket = aws_s3_bucket.demobucket.id
    key    = "/kishor/hello.txt"
    source = "./abc.txt"
}
output "random_string_value" {
  value = random_string.bucket_name.result
}