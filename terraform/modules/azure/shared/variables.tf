
variable "ssh_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
}

variable "suffix" {
  type        = string
  description = "Naming suffix for resources"
}

variable "az_location" {
  type = string
}

variable "az_container_name" {
  type        = string
  description = "Container name"
}

variable "az_resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "az_postgres_username" {
  type        = string
  description = "Postgres username"
  default     = "postgres"
}


variable "az_postgres_password" {
  type        = string
  description = "Postgres password"
  default     = "Mysecretpassword1"
}
locals {
  az_postgresql_server_name          = "${var.prefix}-postgres-server-${var.suffix}"
  workspace_id                       = azurerm_log_analytics_workspace.log.workspace_id
  shared_key                         = azurerm_log_analytics_workspace.log.primary_shared_key
  az_vnet_name                       = "${var.prefix}-vnet-${var.suffix}"
  az_subnet_name                     = "${var.prefix}-subnet-${var.suffix}"
  az_container_service_endpoint_name = "AZ Container Registry"
  az_cluster_name                    = "${var.prefix}-cluster-${var.suffix}"
  host                               = azurerm_kubernetes_cluster.this.kube_config.0.host
  client_certificate                 = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
  client_key                         = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.client_key)
  cluster_ca_certificate             = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
  az_log_analytics_name              = "${var.prefix}-log-analytics-${var.suffix}"



}


