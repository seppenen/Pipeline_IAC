

# This code imports and configures different Terraform modules.

module "ado" {
  source                      = "./modules/ado"
  suffix                      = local.suffix
  prefix                      = var.prefix
  az_location                 = var.az_location
  az_container_name           = local.az_container_name
  az_resource_group_name      = local.az_resource_group_name
  sq_service_connection_token = var.sq_service_connection_token
  sq_service_connection_host  = var.sq_service_connection_host
}

module "backend" {
  source      = "./modules/backend"
  suffix      = local.suffix
  prefix      = var.prefix
  az_location = var.az_location

}

module "shared" {
  source                 = "./modules/azure/shared"
  suffix                 = local.suffix
  prefix                 = var.prefix
  az_location            = var.az_location
  az_container_name      = local.az_container_name
  az_resource_group_name = local.az_resource_group_name
}

module "sonarqube" {
  source                         = "./modules/azure/sonarqube"
  az_location                    = var.az_location
  az_resource_group_name         = local.az_resource_group_name
  host                           = module.shared.kubernetes_host
  client_certificate             = module.shared.kubernetes_client_certificate
  client_key                     = module.shared.kubernetes_client_key
  cluster_ca_certificate         = module.shared.kubernetes_cluster_ca_certificate
  postgresql_jdbc_connection_url = module.shared.postgres_jdbc_connection_string
  postgresql_jdbc_password       = module.shared.postgres_password
  postgresql_jdbc_username       = module.shared.postgres_jdbc_username


}

module "app" {
  source                 = "./modules/azure/temperature_app"
  az_container_name      = local.az_container_name
  az_resource_group_name = local.az_resource_group_name
  host                   = module.shared.kubernetes_host
  client_certificate     = module.shared.kubernetes_client_certificate
  client_key             = module.shared.kubernetes_client_key
  cluster_ca_certificate = module.shared.kubernetes_cluster_ca_certificate
}


module "sq_config" {
  source  = "./modules/sq_config"
  sq_host = local.sonarqube_endpoint
}

