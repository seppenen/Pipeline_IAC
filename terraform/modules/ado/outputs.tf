output "repository_url" {
  value       = azuredevops_git_repository.repo.remote_url
  description = "This is the URL that you would use to clone the repository. It is the same as the repository URL in the Azure DevOps UI."
}

output "project_id" {
  value       = azuredevops_project.this.id
  description = "Project ID for the project created in Azure DevOps"
}

output "postgres_jdbc_connection_string" {
  value = "jdbc:postgresql://${var.prefix}-postgres-server-${var.suffix}.postgres.database.azure.com:5432/postgres"
}
output "postgres_jdbc_username" {
  value = "postgres@${var.prefix}-postgres-server-${var.suffix}"
}

output "access_token" {
  value = local.ado_PAT
}

output "ado_org_name" {
  value = local.ado_org_name
}
