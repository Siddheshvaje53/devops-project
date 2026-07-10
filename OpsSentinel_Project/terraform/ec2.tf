module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_instance_name

  instance_type = var.node_instance_type
  monitoring    = true
  subnet_id     = "subnet-035b0c9656925c5aa"
  ami           = var.ami_id
  region        = var.aws_region

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_instance" "this" {
  subnet_id = "subnet-035b0c9656925c5aa"
  ami       = var.ami_id

    lifecycle {
    ignore_changes = [
      subnet_id, # Prevents recreation if the subnet list order changes
      ami       # Prevents recreation if the AMI ID is updated
    ]
  }
}