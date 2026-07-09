terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = "devops-terraform-state-56789"
  #   key            = "eks/dev/terraform.tfstate"
  #   region         = "ap-south-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}


locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = "devops-team"
  }
}