provider "selectel" {
  token = var.api_token
}

module "project" {
  source        = "../../modules/project"

  project_name  = var.os_project_name
  user_name     = var.os_user_name
  user_pass     = var.os_user_password
}
