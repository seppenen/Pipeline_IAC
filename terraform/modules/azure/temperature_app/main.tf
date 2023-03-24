data "azurerm_container_registry" "acr" {
  name                = var.az_container_name
  resource_group_name = var.az_resource_group_name
}


resource "kubernetes_deployment" "ms-app" {
  metadata {
    name = "microservice-app"
    labels = {
      test = "microservice-app"
    }
  }

  spec {

    selector {
      match_labels = {
        test = "microservice-app"
      }
    }

    template {
      metadata {
        labels = {
          test = "microservice-app"
        }
      }

      spec {
        container {
          image = local.container_registry_image
          name  = "microservice-app"
          resources {
            limits = {
              memory = "2048Mi"
            }
            requests = {
              memory = "1024Mi"
            }
          }
          port {
            container_port = 8080
            protocol       = "TCP"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "ms_service" {
  metadata {
    name = "microservice-app"
  }
  spec {
    selector = {
      test = "microservice-app"
    }
    port {
      name        = "port8080"
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

