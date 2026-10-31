output "load_balancer_controller_release" {
  description = "AWS Load Balancer Controller Helm release"
  value       = helm_release.aws_load_balancer_controller.name
}

output "metrics_server_release" {
  description = "Metrics Server Helm release"
  value       = helm_release.metrics_server.name
}
