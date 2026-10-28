
terraform {
  required_version = ">= 1.5.0"
}

variable "project_name" {
  description = "Name of the enterprise DevOps project."
  type        = string
  default     = "enterprise-cloud-devops"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "development"

  validation {
    condition = contains(
      ["development", "staging", "production"],
      var.environment
    )
    error_message = "Environment must be development, staging, or production."
  }
}

variable "enable_monitoring" {
  description = "Whether monitoring is planned for this environment."
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Common metadata for future cloud resources."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "enterprise-cloud-devops"
  }
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

output "project_name" {
  description = "Name of the DevOps project."
  value       = var.project_name
}

output "environment" {
  description = "Target environment."
  value       = var.environment
}

output "planned_components" {
  description = "Components planned for the project."
  value       = local.required_components
}

output "monitoring_enabled" {
  description = "Whether monitoring is planned."
  value       = var.enable_monitoring
}

output "project_tags" {
  description = "Common project metadata."
  value       = local.tags
}
