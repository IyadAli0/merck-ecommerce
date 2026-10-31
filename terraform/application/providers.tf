provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}
