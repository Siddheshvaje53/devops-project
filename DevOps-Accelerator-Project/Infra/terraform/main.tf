terraform {
  required_version = ">= 1.5.0"

  #Remote Backend
  backend "s3"{
    bucket         = "devops-accelerator-platform-tf-state05072026"
    key            = "global/devops-accelerator/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "devops-accelerator-tf-locker"  #locking
    encrypt        = true
  }
}

provider "aws"{
    region = var.aws_region
}

# Public bucket policy (depends on disabling Block Public Access first)
resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsondecode({
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
            Resource = "${aws_s3_bucket.frontend_bucket.arn}/*"
        }
    ]
  })

  depends_on = [ aws_s3_bucket_public_access_block.frontend_bucket_public_access ]
}


# CORS (optional, for presigned uploads / APIs)
resource "aws_s3_bucket_cors_configuration" "frontend_cors" {
  bucket = aws_s3_bucket.frontend_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "HEAD"]
    allowed_origins = ["https://${aws_cloudfront_distribution.frontend_distribution.domain_name}"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}