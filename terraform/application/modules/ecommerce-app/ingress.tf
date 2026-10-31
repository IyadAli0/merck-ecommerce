resource "kubernetes_ingress_v1" "frontend" {
  metadata {
    name      = "ecommerce-ingress"
    namespace = kubernetes_namespace_v1.app.metadata[0].name
    labels    = var.common_labels

    annotations = {
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/healthz"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.app["frontend"].metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
