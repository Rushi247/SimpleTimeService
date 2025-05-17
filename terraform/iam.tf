data "aws_iam_user" "terraform_user" {
  user_name = "terraform-eks"
}

resource "aws_iam_policy" "terraform_policy" {
  name        = "terraform-eks-full-policy"
  description = "Permissions for EKS, ECR, VPC, S3, DynamoDB"
  policy      = data.aws_iam_policy_document.terraform_permissions.json
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = data.aws_iam_user.terraform_user.user_name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

data "aws_iam_policy_document" "terraform_permissions" {
  statement {
    sid    = "AllowEKS"
    effect = "Allow"
    actions = [
      "eks:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowEC2VPC"
    effect = "Allow"
    actions = [
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowIAMRoles"
    effect = "Allow"
    actions = [
      "iam:PassRole",
      "iam:GetRole",
      "iam:ListRoles"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowECR"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "AllowS3State"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::simpletime-eks17",
      "arn:aws:s3:::simpletime-eks17/*"
    ]
  }

  statement {
    sid    = "AllowDynamoDBLock"
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:DescribeTable"
    ]
    resources = [
      "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/locktable-eks17"
    ]
  }
}

