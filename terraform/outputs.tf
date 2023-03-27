output "repository_url" {
  value = module.ado.repository_url
  # Display the URL for cloning the repository
  description = "URL for cloning the repository from Azure DevOps"
}

output "postgres_jdbc_connection_string" {
  value = module.ado.postgres_jdbc_connection_string
  # Display the JDBC connection string for Postgres
  description = "JDBC connection string for Postgres database"
}

output "postgres_jdbc_username" {
  value = module.ado.postgres_jdbc_username
  # Display the username for accessing the Postgres database
  description = "Username for accessing the Postgres database"
}

output "sonarqube_endpoint" {
  value = module.sonarqube.sonarqube_kubernetes_endpoint
  # Display the endpoint for accessing SonarQube
  description = "Endpoint for accessing SonarQube instance"
}

output "temperature_app_endpoint" {
  value = "${module.app.ms_app_kubernetes_endpoint}/api/v2/temperatures"
  # Display the endpoint for accessing the temperature API
  description = "Endpoint for accessing the temperature API"
}

output "sonarqube_token" {
  value     = module.sq_config.user_token
  sensitive = true
  # Display the token for accessing SonarQube (sensitive)
  description = "User token for accessing SonarQube instance"
}

output "access_token" {
  value     = module.ado.access_token
  sensitive = true
  # Display the access token for Azure DevOps (sensitive)
  description = "Access token for Azure DevOps instance"
}

output "ado_org_name" {
  value     = module.ado.ado_org_name
  sensitive = true
  # Display the name of the Azure DevOps organization (sensitive)
  description = "Name of the Azure DevOps organization"
}
