module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.18"

  name = "simpletime-vpc"

  cidr = "172.20.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["172.20.1.0/24", "172.20.2.0/24"]
  public_subnets  = ["172.20.4.0/24", "172.20.5.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}