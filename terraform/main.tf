terraform {
  required_version = ">= 1.5.0"
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
