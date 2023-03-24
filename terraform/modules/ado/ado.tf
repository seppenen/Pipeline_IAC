
//ADO environment definitions

resource "null_resource" "extensions" {
  provisioner "local-exec" {
    command     = "./scripts/extensions.ps1 -pat ${local.ado_PAT} -orgName ${local.ado_org_name}"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "azuredevops_project" "this" {
  name               = local.ado_project_name
  visibility         = var.ado_project_visibility
  work_item_template = "Agile"
}


resource "azuredevops_project_pipeline_settings" "this" {
  project_id        = azuredevops_project.this.id
  enforce_job_scope = false
}

resource "azuredevops_variable_group" "variable-group" {
  depends_on   = [azurerm_container_registry.acr]
  project_id   = azuredevops_project.this.id
  name         = "pipeline-input-data"
  description  = "Variable group for pipelines"
  allow_access = true

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


