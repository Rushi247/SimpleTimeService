module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = local.cluster_name
  cluster_version = "1.31"

  subnet_ids                     = module.vpc.private_subnets
  vpc_id                         = module.vpc.vpc_id
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    simple_group = {
      name = "simple-group-node"

      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.small"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}