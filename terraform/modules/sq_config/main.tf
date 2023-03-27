//This Terraform code defines a SonarQube user token and a SonarQube project.

//The "sonarqube_user_token" resource creates a new user token in SonarQube for the specified login name.
resource "sonarqube_user_token" "token" {
  login_name = var.sq_admin_login
  name       = "sq-token"
}

//The "sonarqube_project" resource creates a new SonarQube project with the specified name, key, and visibility.
//The key is used to uniquely identify the project and must be unique within the SonarQube instance.
//The visibility of the project can be either "private" or "public".
resource "sonarqube_project" "main" {
  name       = "SonarQube"
  project    = "my_project"
  visibility = "private"
}

