resource "kubernetes_namespace" "app" {
  metadata {
    name = "diplom-app"
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "kubernetes_deployment_v1" "app" {

  metadata {
    name      = "diplom-app"
    namespace = kubernetes_namespace.app.metadata[0].name

    labels = {
      app = "diplom-app"
    }
  }

  spec {

    replicas = 2

    selector {
      match_labels = {
        app = "diplom-app"
      }
    }

    template {

      metadata {
        labels = {
          app = "diplom-app"
        }
      }

      spec {

        container {

          name  = "diplom-app"
          image = local.app_image

          port {
            name           = "http"
            container_port = 80
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = "http"
            }

            initial_delay_seconds = 5
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = "http"
            }

            initial_delay_seconds = 10
            period_seconds        = 20
          }

          resources {
            requests = {
              cpu    = "10m"
              memory = "16Mi"
            }

            limits = {
              cpu    = "100m"
              memory = "64Mi"
            }
          }

        }

      }

    }

  }

  depends_on = [
    helm_release.ingress_nginx
  ]

  lifecycle {
    ignore_changes = [
      spec[0].template[0].spec[0].container[0].image
    ]
  }
}

resource "kubernetes_service_v1" "app" {

  metadata {
    name      = "diplom-app"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {

    selector = {
      app = "diplom-app"
    }

    port {
      name        = "http"
      port        = 80
      target_port = "http"
    }

    type = "ClusterIP"

  }

}

resource "kubernetes_ingress_v1" "app" {

  metadata {
    name      = "diplom-app"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {

    ingress_class_name = "nginx"

    rule {
      http {

        path {

          path      = "/"
          path_type = "Prefix"

          backend {

            service {

              name = kubernetes_service_v1.app.metadata[0].name

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
