provider "openstack" {
  user_name           = var.os_user_name
  tenant_name         = var.os_project_name
  password            = var.os_user_password
  project_domain_name = var.os_domain_name
  user_domain_name    = var.os_domain_name
  auth_url            = var.os_auth_url
  region              = var.os_region
}

module "project" {
  source = "../../modules/project"

  api_token = var.api_token
  project_name = var.os_project_name
  user_name    = var.os_user_name
  user_pass    = var.os_user_password
}

module "network_private_isolate_1" {
  source = "../../modules/network"

  network_name = var.isolate_network_name
  network_CIDR = var.isolate_network_CIDR
}
