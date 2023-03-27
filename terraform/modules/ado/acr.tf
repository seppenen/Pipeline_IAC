// Define the resource group that will contain the container registry
resource "azurerm_resource_group" "this" {
  name     = var.az_resource_group_name
  location = var.az_location
}

// Define the container registry resource
resource "azurerm_container_registry" "acr" {
  name                = var.az_container_name
  resource_group_name = azurerm_resource_group.this.name // Use the resource group defined above
  location            = var.az_location
  sku                 = "Basic"
  admin_enabled       = true

  // Enable system-assigned identity for the container registry
  identity {
    type = "SystemAssigned"
  }
}