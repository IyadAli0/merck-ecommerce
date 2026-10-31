resource "aws_cloudwatch_log_group" "app" {
  name              = "/merck-ecommerce/application"
  retention_in_days = var.log_retention_days

  tags = var.common_labels
}
