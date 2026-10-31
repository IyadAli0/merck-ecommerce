output "namespace" {
  description = "Application Kubernetes namespace"
  value       = module.ecommerce_app.namespace
}

output "frontend_service" {
  description = "Frontend Service name"
  value       = module.ecommerce_app.frontend_service
}

output "backend_service" {
  description = "Backend Service name"
  value       = module.ecommerce_app.backend_service
}

output "ingress_name" {
  description = "Application Ingress name"
  value       = module.ecommerce_app.ingress_name
}

output "cloudwatch_log_group" {
  description = "Application CloudWatch log group"
  value       = module.ecommerce_app.cloudwatch_log_group
}
