locals {
  workloads = {
    backend = {
      image    = var.backend_image
      replicas = 2
      port     = 8000
      requests = { cpu = "100m", memory = "128Mi" }
      limits   = { cpu = "500m", memory = "512Mi" }
    }

    frontend = {
      image    = var.frontend_image
      replicas = 1
      port     = 80
      requests = { cpu = "50m", memory = "64Mi" }
      limits   = { cpu = "200m", memory = "128Mi" }
    }
  }
}

resource "kubernetes_deployment_v1" "app" {
  for_each = local.workloads

  metadata {
    name      = each.key
    namespace = kubernetes_namespace_v1.app.metadata[0].name
    labels    = merge(var.common_labels, { app = each.key })
  }

  spec {
    replicas = each.value.replicas

    selector {
      match_labels = {
        app = each.key
      }
    }

    template {
      metadata {
        labels = merge(var.common_labels, { app = each.key })
      }

      spec {
        container {
          name              = each.key
          image             = each.value.image
          image_pull_policy = "IfNotPresent"

          port {
            name           = "http"
            container_port = each.value.port
          }

          resources {
            requests = each.value.requests
            limits   = each.value.limits
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = "http"
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = "http"
            }
            initial_delay_seconds = 3
            period_seconds        = 5
          }

          dynamic "env_from" {
            for_each = each.key == "backend" ? [1] : []

            content {
              config_map_ref {
                name = kubernetes_config_map_v1.app.metadata[0].name
              }
            }
          }
        }
      }
    }
  }
}
