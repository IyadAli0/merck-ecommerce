variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "merck-ecommerce"
}

variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.34"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)

  default = {
    Project     = "merck-ecommerce"
    Environment = "assessment"
    ManagedBy   = "Terraform"
  }
}
