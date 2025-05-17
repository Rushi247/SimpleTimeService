terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
  }

  backend "s3" {
    bucket         = "simpletime-eks17"
    key            = "simpletimeservice/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "locktable-eks17"
  }
}