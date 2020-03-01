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
  network_CIDR = "${var.isolate_network_CIDR}0/24"
}

module "network_private_1" {
  source = "../../modules/network"

  network_name = var.private_network_name
  network_CIDR = "${var.private_network_CIDR}0/24"
}

module "api_node_remote_disk_two_lan" {
  source            = "../../modules/instance"
  instance_numbers  = var.api_node_remote_disk_two_lan_numbers

  name        = "api"
  hostname    = "instance"
  server_az   = "ru-3a"
  volume_type = "fast"
  volume_size = 30
  flavor_id   = "1014"
  key_pair    = module.keypair.ssh_key_id

  first_network_name        = var.isolate_network_name
  first_ip_subnet           = var.isolate_network_CIDR
  first_start_ip            = "10"
  first_network_id          = module.network_private_isolate_1.returned_network_id
  first_network_subnet_id   = module.network_private_isolate_1.returned_network_subnet_id
  second_network_name       = var.private_network_name
  second_ip_subnet          = var.private_network_CIDR
  second_start_ip           = "23"
  second_network_id         = module.network_private_1.returned_network_id
  second_network_subnet_id  = module.network_private_1.returned_network_subnet_id
}

module "api_node_remote_disk_one_lan" {
  source            = "../../modules/instance"
  instance_numbers  = var.api_node_remote_disk_one_lan_numbers

  name        = "srv"
  hostname    = "instance"
  server_az   = "ru-3a"
  volume_type = "fast"
  volume_size = 30
  flavor_id   = "1014"
  key_pair    = module.keypair.ssh_key_id

  first_network_name        = var.isolate_network_name
  first_ip_subnet           = var.isolate_network_CIDR
  first_start_ip            = "52"
  first_network_id          = module.network_private_isolate_1.returned_network_id
  first_network_subnet_id   = module.network_private_isolate_1.returned_network_subnet_id
}

module "api_node_local_disk_one_lan" {
  source            = "../../modules/instance"
  instance_numbers  = var.api_node_remote_disk_one_lan_numbers

  name        = "api"
  hostname    = "instance"
  server_az   = "ru-3a"
  flavor_id   = "1314"
  key_pair    = module.keypair.ssh_key_id

  first_network_name        = var.isolate_network_name
  first_ip_subnet           = var.isolate_network_CIDR
  first_start_ip            = "3"
  first_network_id          = module.network_private_isolate_1.returned_network_id
  first_network_subnet_id   = module.network_private_isolate_1.returned_network_subnet_id
}

module "api_node_local_disk_two_lan" {
  source            = "../../modules/instance"
  instance_numbers  = var.api_node_remote_disk_one_lan_numbers

  name        = "net"
  hostname    = "instance"
  server_az   = "ru-3a"
  flavor_id   = "1314"
  key_pair    = module.keypair.ssh_key_id

  first_network_name        = var.isolate_network_name
  first_ip_subnet           = var.isolate_network_CIDR
  first_start_ip            = "15"
  first_network_id          = module.network_private_isolate_1.returned_network_id
  first_network_subnet_id   = module.network_private_isolate_1.returned_network_subnet_id
  second_network_name       = var.private_network_name
  second_ip_subnet          = var.private_network_CIDR
  second_start_ip           = "15"
  second_network_id         = module.network_private_1.returned_network_id
  second_network_subnet_id  = module.network_private_1.returned_network_subnet_id
}
