// Define Azure client configuration data source
data "azurerm_client_config" "current" {}

// Define Azure resource group
resource "azurerm_resource_group" "this" {
  name = local.az_storage_resource_group_name
  location = var.az_location
}

// Define Azure storage account
resource "azurerm_storage_account" "sa" {
  depends_on = [azurerm_resource_group.this]
  name = local.az_storage_account_name
  resource_group_name = local.az_storage_resource_group_name
  location = var.az_location
  account_tier = "Standard"
  account_replication_type = "LRS"
}


// Define Azure storage container
resource "azurerm_storage_container" "ct" {
  name = local.az_storage_container_name
  storage_account_name = azurerm_storage_account.sa.name
}

// Overwrite the Terraform backend file with Azure storage configuration
resource "local_file" "post-config" {
  depends_on = [azurerm_storage_container.ct]

  filename = "${path.root}/backend.tf"
  content = <<EOF
// Do not commit this file.
terraform {
backend "azurerm" {
resource_group_name = "${local.az_storage_resource_group_name}"
storage_account_name = "${local.az_storage_account_name}"
container_name = "${local.az_storage_container_name}"
key = "${local.az_storage_tfstate_key}"
}
}
EOF
}