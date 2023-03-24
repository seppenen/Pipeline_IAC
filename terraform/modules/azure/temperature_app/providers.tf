
provider "azurerm" {
  features {}

}

provider "kubernetes" {
  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.42.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.19"
    }
  }
}