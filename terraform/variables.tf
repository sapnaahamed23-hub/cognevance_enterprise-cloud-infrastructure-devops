
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
