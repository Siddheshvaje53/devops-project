module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~>20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_size = var.desired_capacity
      max_size     = var.max_capacity
      min_size     = var.min_capacity

      instance_types = [var.node_instance_type]
    }
  }

  tags = {
    Environment = "dev"
  }
}