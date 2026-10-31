resource "kubernetes_service_v1" "app" {
  for_each = local.workloads

  metadata {
    name      = each.key
    namespace = kubernetes_namespace_v1.app.metadata[0].name
    labels    = merge(var.common_labels, { app = each.key })
  }

  spec {
    selector = {
      app = each.key
    }

    port {
      name        = "http"
      port        = each.value.port
      target_port = "http"
    }

    type = "ClusterIP"
  }
}
