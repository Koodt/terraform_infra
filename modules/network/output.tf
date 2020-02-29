output "returned_first_network_id" {
  value = openstack_networking_network_v2.network.id
}

output "returned_first_network_subnet_id" {
  value = openstack_networking_subnet_v2.network_subnet.id
}

