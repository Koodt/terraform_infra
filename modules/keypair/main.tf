resource "openstack_compute_keypair_v2" "access_ssh_key" {
  name          = "${var.project_name}_ssh_key"
  region        = var.region
  public_key    = var.ssh_key
}
