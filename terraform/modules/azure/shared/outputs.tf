# Output the Kubernetes host
output "kubernetes_host" {
  value = azurerm_kubernetes_cluster.this.kube_config.0.host
}

# Output the Kubernetes client certificate
output "kubernetes_client_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
}

# Output the Kubernetes client key
output "kubernetes_client_key" {
  value = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.client_key)
}

# Output the Kubernetes cluster CA certificate
output "kubernetes_cluster_ca_certificate" {
  value = base64decode(azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
}

# Output the Postgres JDBC connection string
output "postgres_jdbc_connection_string" {
  value = "jdbc:postgresql://${azurerm_postgresql_server.postgres.fqdn}:5432/postgres"
}

# Output the Postgres JDBC username
output "postgres_jdbc_username" {
  value = "${azurerm_postgresql_server.postgres.administrator_login}@${azurerm_postgresql_server.postgres.name}"
}

# Output the Postgres password
output "postgres_password" {
  value = azurerm_postgresql_server.postgres.administrator_login_password
}
