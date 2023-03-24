output "repository_url" {
  value       = module.ado.repository_url
  description = "This is the URL that you would use to clone the repository. It is the same as the repository URL in the Azure DevOps UI."
}

output "postgres_jdbc_connection_string" {
  value = module.ado.postgres_jdbc_connection_string
}
output "postgres_jdbc_username" {
  value = module.ado.postgres_jdbc_username
}


output "sonarqube_endpoint" {
  value = module.sonarqube.sonarqube_kubernetes_endpoint
}
output "temperature_app_endpoint" {
  value = "${module.app.ms_app_kubernetes_endpoint}/api/v2/temperatures"
}

output "sonarqube_token" {
  value     = module.sq_config.user_token
  sensitive = true
}

output "access_token" {
  value     = module.ado.access_token
  sensitive = true
}

output "ado_org_name" {
  value     = module.ado.ado_org_name
  sensitive = true
}
