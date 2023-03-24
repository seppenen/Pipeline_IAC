
//Service connection endpoints

data "azurerm_client_config" "current" {}

resource "azuredevops_serviceendpoint_runpipeline" "pipeline" {
  project_id            = azuredevops_project.this.id
  service_endpoint_name = "Pipeline_IAC"
  organization_name     = local.ado_org_name
  auth_personal {
    personal_access_token = local.ado_PAT
  }
  description = "Managed by Terraform"
}


resource "azuredevops_serviceendpoint_dockerregistry" "acr" {
  project_id            = azuredevops_project.this.id
  service_endpoint_name = local.az_container_service_endpoint_name
  docker_registry       = azurerm_container_registry.acr.login_server
  docker_username       = azurerm_container_registry.acr.admin_username
  docker_password       = azurerm_container_registry.acr.admin_password
  registry_type         = "Others"
  description           = "This service endpoint is used to access the container registry"
}

resource "azuredevops_serviceendpoint_azurerm" "rm" {
  project_id            = azuredevops_project.this.id
  service_endpoint_name = "AzureRM"
  description           = "Managed by Terraform"
  credentials {
    serviceprincipalid  = local.service_principal_id
    serviceprincipalkey = local.service_principal_key
  }
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_client_config.current.subscription_id
  azurerm_subscription_name = "Reference Pipeline"
}

resource "azuredevops_resource_authorization" "kv_auth" {
  project_id  = azuredevops_project.this.id
  resource_id = azuredevops_serviceendpoint_dockerregistry.acr.id
  authorized  = true
}

resource "azuredevops_resource_authorization" "rm_auth" {
  project_id  = azuredevops_project.this.id
  resource_id = azuredevops_serviceendpoint_azurerm.rm.id
  authorized  = true
}

resource "azuredevops_serviceendpoint_sonarqube" "sq-connection" {
  project_id            = azuredevops_project.this.id
  service_endpoint_name = "sonarqube"
  url                   = "http://${var.sq_service_connection_host}"
  token                 = var.sq_service_connection_token
}

resource "azuredevops_resource_authorization" "sq_auth" {
  project_id  = azuredevops_project.this.id
  resource_id = azuredevops_serviceendpoint_sonarqube.sq-connection.id
  authorized  = true
}

resource "azuredevops_resource_authorization" "pipeline_auth" {
  project_id  = azuredevops_project.this.id
  resource_id = azuredevops_serviceendpoint_runpipeline.pipeline.id
  authorized  = true
}