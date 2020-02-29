output "ssh_key_id" {
  value = openstack_compute_keypair_v2.access_ssh_key.id
}
