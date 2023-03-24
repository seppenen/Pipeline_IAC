

resource "azurerm_postgresql_server" "postgres" {
  name                = local.az_postgresql_server_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.az_location

  administrator_login          = var.az_postgres_username
  administrator_login_password = var.az_postgres_password

  sku_name   = "B_Gen5_1"
  version    = "11"
  storage_mb = 640000

  backup_retention_days            = 7
  auto_grow_enabled                = true
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

}

resource "azurerm_postgresql_firewall_rule" "firewall" {
  name                = "AllowAll"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
