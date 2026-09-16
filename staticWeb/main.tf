
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
resource "aws_s3_bucket" "mywebapp-bucket" {
    bucket = "mywebapp-${lower(random_string.bucket_name.result)}-123"
    force_destroy = true
   
}
resource "aws_s3_bucket_public_access_block" "mywebapp-bucket" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Sid"       = "PublicReadGetObject",
        "Effect"    = "Allow",
        "Principal" = "*",
        "Action"    = "s3:GetObject",
        "Resource"  = "arn:aws:s3:::${aws_s3_bucket.mywebapp-bucket.bucket}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.mywebapp-bucket]
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.mywebapp-bucket.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.mywebapp-bucket.id
  key          = "style.css"
  source       = "./style.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "random_string_value" {
  value = random_string.bucket_name.result
}

output "website_url" {
  description = "The URL of the static website"
  value       = "http://${aws_s3_bucket_website_configuration.mywebapp.website_endpoint}"
}