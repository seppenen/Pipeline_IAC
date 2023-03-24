
//Azure environment & application shared resources

data "azurerm_container_registry" "acr" {
  name                = var.az_container_name
  resource_group_name = var.az_resource_group_name
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = local.az_cluster_name
  location            = var.az_location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = local.az_cluster_name

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = "${trimspace(tls_private_key.key.public_key_openssh)} azureuser@azure.com"
    }
  }
  default_node_pool {
    name                = "vmpool29392"
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    vm_size             = "Standard_B2ms"

    linux_os_config {
      sysctl_config {
        fs_file_max      = 131072
        vm_max_map_count = 262144
      }
    }
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id
  }
}

resource "azurerm_role_assignment" "enablePulling" {
  depends_on                       = [azurerm_kubernetes_cluster.this]
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = false
}
