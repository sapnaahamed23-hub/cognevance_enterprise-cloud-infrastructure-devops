terraform {
  required_version = ">= 1.5.0"
}

# Initial Terraform foundation.
# This configuration does not create cloud resources.

locals {
  project_name = "enterprise-cloud-devops"
  environment  = "development"

  required_components = [
    "terraform",
    "docker",
    "kubernetes",
    "github-actions",
    "prometheus",
    "grafana"
  ]

  tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
  }
}

output "project_name" {
  description = "Name of the DevOps project."
  value       = local.project_name
}

output "environment" {
  description = "Target environment."
  value       = local.environment
}

output "planned_components" {
  description = "Components planned for the project."
  value       = local.required_components
}

output "project_tags" {
  description = "Common project metadata."
  value       = local.tags
}
