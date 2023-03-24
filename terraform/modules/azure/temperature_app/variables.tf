
variable "az_container_name" {
  type        = string
  description = "Container name"
}
variable "az_resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "host" {
  type        = string
  description = "Kubernetes host"
}

variable "client_certificate" {
  type        = string
  description = "Kubernetes client certificate"
}

variable "client_key" {
  type        = string
  description = "Kubernetes client key"
}

variable "cluster_ca_certificate" {
  type        = string
  description = "Kubernetes CA certificate"
}

locals {
  container_registry_image = "${data.azurerm_container_registry.acr.login_server}/${var.az_container_name}:latest"
}