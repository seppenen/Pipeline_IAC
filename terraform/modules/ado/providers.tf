provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/${local.ado_org_name}"
  personal_access_token = local.ado_PAT
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
    env = {
      source  = "tchupp/env"
      version = "0.0.2"
    }
  }
}
