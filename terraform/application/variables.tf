variable "aws_region" {
  description = "AWS region for infrastructure resources"
  type        = string
  default     = "eu-west-1"
}

variable "kubeconfig_path" {
  description = "Path to the Kubernetes kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "tags" {
  description = "Common tags applied to AWS resources"
  type        = map(string)

  default = {
    Project     = "merck-ecommerce"
    Environment = "assessment"
    ManagedBy   = "Terraform"
  }
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "merck"
}

variable "backend_image" {
  description = "Backend container image"
  type        = string
  default     = "merck-backend:1.0"
}

variable "frontend_image" {
  description = "Frontend container image"
  type        = string
  default     = "merck-frontend:1.0"
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}
