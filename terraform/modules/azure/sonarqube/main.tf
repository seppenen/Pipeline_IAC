// Define a Kubernetes deployment for SonarQube
resource "kubernetes_deployment" "sonarqube" {
  // Set the metadata for the deployment
  metadata {
    name = "sonarqube"
    labels = {
      test = "sonarqube"
    }
  }
  // Set the deployment spec
  spec {
    // Set the selector for the deployment
    selector {
      match_labels = {
        test = "sonarqube"
      }
    }
    // Set the deployment template
    template {
      // Set the metadata for the template
      metadata {
        labels = {
          test = "sonarqube"
        }
      }
      // Set the container spec for the template
      spec {
        container {
          // Set the Docker image for the container
          image = "docker.io/sonarqube:8.9.9-community"
          name  = "sonarqube"

          // Set the resource limits for the container
          resources {
            limits = {
              memory = "2048Mi"
            }
            requests = {
              memory = "1024Mi"
            }
          }
          // Set the port mapping for the container
          port {
            container_port = 9000
            protocol       = "TCP"
          }

          // Set the environment variables for SonarQube
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

// Define a Kubernetes service for SonarQube
resource "kubernetes_service" "sq_service" {
  // Set the metadata for the service
  metadata {
    name = "sonarqube"
  }

  // Set the service spec
  spec {
    // Set the selector for the service
    selector = {
      test = "sonarqube"
    }
    // Set the port mapping for the service
    port {
      name        = "port9000"
      port        = 80
      target_port = 9000
    }
    // Set the type of service to LoadBalancer
    type = "LoadBalancer"
  }
}

// Define a Terraform resource that waits 60 seconds for the deployment to complete
resource "time_sleep" "preparing_sonarqube_60_seconds" {
  depends_on      = [kubernetes_deployment.sonarqube]
  create_duration = "60s"
}
