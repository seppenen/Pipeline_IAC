
data "azurerm_resource_group" "this" {
  name = var.az_resource_group_name
}


resource "azurerm_log_analytics_workspace" "log" {
  name                = local.az_log_analytics_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}