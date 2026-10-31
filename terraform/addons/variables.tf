variable "aws_region" {
  description = "AWS region where the EKS cluster is deployed"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Existing EKS cluster name"
  type        = string
  default     = "merck-ecommerce"
}

variable "load_balancer_controller_role_arn" {
  description = "IAM role ARN created by the infrastructure Terraform root"
  type        = string
}
