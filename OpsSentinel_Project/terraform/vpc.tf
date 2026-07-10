module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = "devops-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "dev"
  }
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id
  tags   = { Name = "tf-simple-igw" }
}