
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

locals {
  az_storage_resource_group_name = "${var.prefix}-backend-${var.suffix}"
  az_storage_account_name        = "${var.prefix}storage${var.suffix}"
  az_storage_container_name      = "${var.prefix}-terraform-state-${var.suffix}"
  az_storage_tfstate_key         = "dev-tfstate-${var.suffix}"
}

