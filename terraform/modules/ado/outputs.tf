// This output will display the remote URL of the repository
output "repository_url" {
  value       = azuredevops_git_repository.repo.remote_url
  description = "This is the URL that you would use to clone the repository. It is the same as the repository URL in the Azure DevOps UI."
}

// This output will display the project ID
output "project_id" {
  value       = azuredevops_project.this.id
  description = "Project ID for the project created in Azure DevOps"
}

// This output will display the JDBC connection string for the PostgreSQL server
output "postgres_jdbc_connection_string" {
  value = "jdbc:postgresql://${var.prefix}-postgres-server-${var.suffix}.postgres.database.azure.com:5432/postgres"
}

// This output will display the username to connect to the PostgreSQL server
output "postgres_jdbc_username" {
  value = "postgres@${var.prefix}-postgres-server-${var.suffix}"
}

// This output will display the access token used for authenticating with Azure DevOps
output "access_token" {
  value = local.ado_PAT
}

// This output will display the name of the Azure DevOps organization
output "ado_org_name" {
  value = local.ado_org_name
}