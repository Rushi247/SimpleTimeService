variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "clusterName" {
  description = "Name of the EKS cluster"
  default     = "simpletime-eks"
}

variable "container_image" {
  description = "ECR image URI"
  default     = "615299762892.dkr.ecr.us-east-1.amazonaws.com/simpletimeservice:latest"
}