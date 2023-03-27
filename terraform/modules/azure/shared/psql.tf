# Creates an Azure PostgreSQL server
resource "azurerm_postgresql_server" "postgres" {
  name                = local.az_postgresql_server_name
  resource_group_name = data.azurerm_resource_group.this.name
  location            = var.az_location

  administrator_login          = var.az_postgres_username
  administrator_login_password = var.az_postgres_password

  sku_name   = "B_Gen5_1"        # Set SKU tier for PostgreSQL server
  version    = "11"              # Set PostgreSQL server version
  storage_mb = 640000            # Set storage size for PostgreSQL server

  backup_retention_days            = 7      # Set backup retention days for PostgreSQL server
  auto_grow_enabled                = true   # Enable auto-grow for PostgreSQL server storage
  ssl_enforcement_enabled          = false  # Disable SSL enforcement for PostgreSQL server
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"  # Set minimal TLS version enforced for PostgreSQL server
}

# Creates a firewall rule for the PostgreSQL server
resource "azurerm_postgresql_firewall_rule" "firewall" {
  name                = "AllowAll"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = "0.0.0.0"         # Set the start IP address for firewall rule
  end_ip_address      = "255.255.255.255" # Set the end IP address for firewall rule
}
