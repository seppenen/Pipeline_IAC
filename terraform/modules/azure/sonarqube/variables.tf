
variable "az_location" {
  type = string
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

variable "postgresql_jdbc_username" {
  type        = string
  description = "Kubernetes CA certificate"
}

variable "postgresql_jdbc_password" {
  type        = string
  description = "Kubernetes CA certificate"
}

variable "postgresql_jdbc_connection_url" {
  type        = string
  description = "Kubernetes CA certificate"
}
