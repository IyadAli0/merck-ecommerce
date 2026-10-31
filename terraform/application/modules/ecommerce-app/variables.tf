variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "merck"
}

variable "backend_image" {
  description = "Backend Docker image"
  type        = string
}

variable "frontend_image" {
  description = "Frontend Docker image"
  type        = string
}

variable "common_labels" {
  description = "Labels applied to Kubernetes resources"
  type        = map(string)
}

variable "log_retention_days" {
  description = "CloudWatch log retention period"
  type        = number
  default     = 30
}
