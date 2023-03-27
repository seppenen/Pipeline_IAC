// Define a null resource to execute a local PowerShell script for Azure DevOps (ADO) extensions
resource "null_resource" "extensions" {
  provisioner "local-exec" {
    // Execute the PowerShell script with the specified ADO personal access token and organization name
    command     = "./scripts/extensions.ps1 -pat ${local.ado_PAT} -orgName ${local.ado_org_name}"
    interpreter = ["PowerShell", "-Command"]
  }
}

// Define an Azure DevOps project resource with the specified name and visibility
resource "azuredevops_project" "this" {
  name               = local.ado_project_name
  visibility         = var.ado_project_visibility
  work_item_template = "Agile"
}

// Define Azure DevOps project pipeline settings with the project ID and job scope enforcement
resource "azuredevops_project_pipeline_settings" "this" {
  project_id        = azuredevops_project.this.id
  enforce_job_scope = false
}

// Define an Azure DevOps variable group with the specified project ID, name, and description
resource "azuredevops_variable_group" "variable-group" {
  depends_on   = [azurerm_container_registry.acr]
  project_id   = azuredevops_project.this.id
  name         = "pipeline-input-data"
  description  = "Variable group for pipelines"
  allow_access = true

  // Define variables with their names and values
  variable {
    name  = "repository_name"
    value = azurerm_container_registry.acr.name
  }

  variable {
    name  = "az_storage_resource_group"
    value = local.az_storage_resource_group_name
  }

  variable {
    name  = "az_storage_account_name"
    value = local.az_storage_account_name
  }

  variable {
    name  = "az_storage_container_name"
    value = local.az_storage_container_name
  }

  variable {
    name  = "az_storage_tfstate_key"
    value = local.az_storage_tfstate_key
  }
}
