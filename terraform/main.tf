provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.auth.token
}

data "aws_eks_cluster_auth" "auth" {
  name = module.eks.cluster_name
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.clusterName
}

resource "kubernetes_deployment" "app" {
  depends_on = [module.eks]

  metadata {
    name = "simpletime"
    labels = {
      app = "simpletime"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "simpletime"
      }
    }

    template {
      metadata {
        labels = {
          app = "simpletime"
        }
      }

      spec {
        container {
          image = var.container_image
          name  = "simpletime"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = "simpletime-service"
  }

  spec {
    selector = {
      app = "simpletime"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 8080
      protocol    = "TCP"
    }
  }
}