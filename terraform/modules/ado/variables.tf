variable "ado_project_visibility" {
  type    = string
  default = "private"
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

variable "sq_service_connection_host" {
  type = string
}

variable "sq_service_connection_token" {
  type = string
}

data "env_variable" "secrets" {
  for_each = toset([
    "ARM_CLIENT_ID",
    "ARM_CLIENT_SECRET",
    "AZDO_PERSONAL_ACCESS_TOKEN",
    "AZDO_ORG_NAME"
  ])
  name = each.key
}

variable "pipeline" {
  type = map(object({
    name        = string
    branch_name = string
    yml_path    = string
  }))
  description = "Pipeline build definitions"
  default = {
    "main" = {
      name        = "Main"
      branch_name = "refs/heads/main"
      yml_path    = "azure-pipeline-main.yml"
    },
    "feature" = {
      name        = "Feature"
      branch_name = "refs/heads/feature"
      yml_path    = "azure-pipeline-feature.yml"
    }
  }
}

locals {
  service_principal_id               = data.env_variable.secrets["ARM_CLIENT_ID"].value
  service_principal_key              = data.env_variable.secrets["ARM_CLIENT_SECRET"].value
  ado_PAT                            = data.env_variable.secrets["AZDO_PERSONAL_ACCESS_TOKEN"].value
  ado_org_name                       = data.env_variable.secrets["AZDO_ORG_NAME"].value
  ado_project_name                   = "${var.prefix}-project-${var.suffix}"
  ado_repository_name                = "${var.prefix}-pipeline-${var.suffix}"
  az_container_service_endpoint_name = "ACR connection"
  az_lib_service_endpoint_name       = "Ext-TF-lib"
  az_storage_resource_group_name     = "${var.prefix}-backend-${var.suffix}"
  az_storage_account_name            = "${var.prefix}storage${var.suffix}"
  az_storage_container_name          = "${var.prefix}-terraform-state-${var.suffix}"
  az_storage_tfstate_key             = "dev-tfstate-${var.suffix}"
}
