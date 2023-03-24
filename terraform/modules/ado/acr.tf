resource "azurerm_resource_group" "this" {
  name     = var.az_resource_group_name
  location = var.az_location
}

resource "azurerm_container_registry" "acr" {
  name                = var.az_container_name
  resource_group_name = azurerm_resource_group.this.name
  location            = var.az_location
  sku                 = "Basic"
  admin_enabled       = true

  identity {
    type = "SystemAssigned"
  }
}

