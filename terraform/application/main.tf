locals {
  common_labels = {
    "app.kubernetes.io/part-of"    = "merck-ecommerce"
    "app.kubernetes.io/managed-by" = "Terraform"
  }
}

module "ecommerce_app" {
  source = "./modules/ecommerce-app"

  namespace          = var.namespace
  backend_image      = var.backend_image
  frontend_image     = var.frontend_image
  common_labels      = local.common_labels
  log_retention_days = var.log_retention_days
}
