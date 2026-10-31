output "namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace_v1.app.metadata[0].name
}

output "frontend_service" {
  description = "Frontend Kubernetes Service"
  value       = kubernetes_service_v1.app["frontend"].metadata[0].name
}

output "backend_service" {
  description = "Backend Kubernetes Service"
  value       = kubernetes_service_v1.app["backend"].metadata[0].name
}

output "ingress_name" {
  description = "Application Ingress resource"
  value       = kubernetes_ingress_v1.frontend.metadata[0].name
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group"
  value       = aws_cloudwatch_log_group.app.name
}
