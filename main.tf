variable "aws_access_key_id" {
  description = "The AWS access key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "The AWS secret access key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "source_directory" {
  description = "The directory containing the website files"
  type        = string
  default     = "quizz-app"
}


provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  region     = "ap-south-1"
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "batmans3bucket1234" 
  acl    = "private"  

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "website_index" {
  bucket      = aws_s3_bucket.website_bucket.bucket
  key         = "index.html"  
  source      = "${var.source_directory}/index.html" 
  content_type = "text/html"  
}

resource "aws_s3_object" "website_style" {
  bucket      = aws_s3_bucket.website_bucket.bucket
  key         = "style.css"  
  source      = "${var.source_directory}/style.css"  
  content_type = "text/css" 
}

resource "aws_s3_object" "website_script" {
  bucket      = aws_s3_bucket.website_bucket.bucket
  key         = "script.js"  
  source      = "${var.source_directory}/script.js"  
  content_type = "application/javascript"  
}

resource "aws_s3_bucket_public_access_block" "website_bucket_public_access_block" {
  bucket = aws_s3_bucket.website_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Principal = "*"
        Resource  = "arn:aws:s3:::batmans3bucket1234/*"  
      },
    ]
  })
}









