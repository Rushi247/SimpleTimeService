data "aws_caller_identity" "current" {}

resource "aws_eks_access_entry" "terraform_eks" {
  depends_on = [module.eks]

  cluster_name = module.eks.cluster_name

  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/terraform-eks"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "terraform_eks_admin_policy" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.terraform_eks.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}