provider "openstack" {
  user_name           = var.os_user_name
  tenant_name         = var.os_project_name
  password            = var.os_user_password
  project_domain_name = var.os_domain_name
  user_domain_name    = var.os_domain_name
  auth_url            = var.os_auth_url
  region              = var.os_region
}

module "keypair" {
  source = "../../modules/keypair"

  project_name  = var.os_project_name
  region        = var.os_region
  ssh_key       = var.ssh_key
}

module "network_private_isolate_1" {
  source = "../../modules/network"

  network_name = var.isolate_network_name
  network_CIDR = var.isolate_network_CIDR
}

module "api_node" {
  source            = "../../modules/instance"
  instance_numbers  = var.api_node_numbers

  name        = "api"
  hostname    = "instance"
  server_az   = "ru-3a"
  volume_type = "fast"
  volume_size = 30
  flavor_id   = "1014"
  key_pair    = module.keypair.ssh_key_id

  first_ip_subnet                = "192.168.0."
  first_network_id        = module.network_private_isolate_1.returned_first_network_id
  first_network_subnet_id = module.network_private_isolate_1.returned_first_network_subnet_id
}

# module "vm_onelan_localdisk" {
#   source = "../../modules/instance"

#   fqdn      = "my.server.hostname"
#   hostname  = "instance"
#   server_az = "ru-3a"
#   flavor_id = "1314"
#   key_pair  = module.keypair.ssh_key_id
#   image_id  = "5842d2ca-8c3d-40b7-8017-5cfad4e23736"

#   first_ip                = "192.168.0.110"
#   first_network_id        = module.network_private_isolate_1.returned_first_network_id
#   first_network_subnet_id = module.network_private_isolate_1.returned_first_network_subnet_id
# }
