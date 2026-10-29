
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}

locals {
  required_components = [
    "terraform",
    "docker",
    "kubernetes",
    "github-actions",
    "prometheus",
    "grafana"
  ]

  tags = merge(
    var.common_tags,
    {
      Environment = var.environment
      Project     = var.project_name
    }
  )
}

resource "kubernetes_config_map_v1" "project_info" {
  metadata {
    name      = "terraform-project-info"
    namespace = "enterprise-dev"

    labels = {
      project     = var.project_name
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  data = {
    project_name        = var.project_name
    environment         = var.environment
    monitoring_enabled  = tostring(var.enable_monitoring)
    managed_by          = "Terraform"
    infrastructure_type = "Minikube"
  }
}

output "project_name" {
  value = var.project_name
}

output "environment" {
  value = var.environment
}

output "managed_config_map" {
  value = kubernetes_config_map_v1.project_info.metadata[0].name
}
