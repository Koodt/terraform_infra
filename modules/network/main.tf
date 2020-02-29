resource "openstack_networking_network_v2" "network" {
  name = var.network_name
}

resource "openstack_networking_subnet_v2" "network_subnet" {
  network_id    = openstack_networking_network_v2.network.id
  name          = var.network_name
  cidr          = var.network_CIDR
  enable_dhcp   = "false"
}
