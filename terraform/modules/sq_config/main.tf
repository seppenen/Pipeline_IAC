
resource "sonarqube_user_token" "token" {
  login_name = var.sq_admin_login
  name       = "sq-token"
}

resource "sonarqube_project" "main" {
  name       = "SonarQube"
  project    = "my_project"
  visibility = "private"
}

