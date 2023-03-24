
resource "kubernetes_deployment" "sonarqube" {
  metadata {
    name = "sonarqube"
    labels = {
      test = "sonarqube"
    }
  }
  spec {
    selector {
      match_labels = {
        test = "sonarqube"
      }
    }

    template {
      metadata {
        labels = {
          test = "sonarqube"
        }
      }
      spec {
        container {
          image = "docker.io/sonarqube:8.9.9-community"
          name  = "sonarqube"

          resources {
            limits = {
              memory = "2048Mi"
            }
            requests = {
              memory = "1024Mi"
            }
          }
          port {
            container_port = 9000
            protocol       = "TCP"
          }

          env {
            name  = "SONAR_JDBC_USERNAME"
            value = var.postgresql_jdbc_username
          }
          env {
            name  = "SONAR_JDBC_PASSWORD"
            value = var.postgresql_jdbc_password
          }
          env {
            name  = "SONAR_JDBC_URL"
            value = var.postgresql_jdbc_connection_url
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "sq_service" {
  metadata {
    name = "sonarqube"
  }

  spec {
    selector = {
      test = "sonarqube"
    }
    port {
      name        = "port9000"
      port        = 80
      target_port = 9000
    }
    type = "LoadBalancer"
  }


}

resource "time_sleep" "preparing_sonarqube_60_seconds" {
  depends_on      = [kubernetes_deployment.sonarqube]
  create_duration = "60s"
}