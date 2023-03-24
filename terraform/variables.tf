variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "alex"
}


variable "az_location" {
  type    = string
  default = "swedencentral"
}

variable "sq_service_connection_host" {
  type    = string
  default = "123"
}

variable "sq_service_connection_token" {
  type    = string
  default = "123"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

locals {
  suffix                 = random_integer.suffix.result
  sonarqube_endpoint     = module.sonarqube.sonarqube_kubernetes_endpoint
  project_id             = module.ado.project_id
  az_container_name      = "${var.prefix}container${local.suffix}"
  az_resource_group_name = "${var.prefix}-${local.suffix}"
}
