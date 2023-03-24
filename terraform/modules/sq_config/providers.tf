
terraform {
  required_providers {
    sonarqube = {
      source  = "jdamata/sonarqube"
      version = "0.15.6"
    }
  }
}

provider "sonarqube" {
  user = var.sq_admin_login
  pass = var.sq_admin_login_password
  host = "http://${var.sq_host}"
}


