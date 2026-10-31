resource "kubernetes_config_map_v1" "app" {
  metadata {
    name      = "ecommerce-config"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
  }

  data = {
    APP_ENV   = "production"
    LOG_LEVEL = "info"
  }
}
