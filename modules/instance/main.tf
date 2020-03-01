data "openstack_images_image_v2" "vm_image" {
  name = var.image
}

resource "openstack_compute_servergroup_v2" "api_nodes" {
  count = "%{ if var.use_anti_affinity }1%{else}0%{endif}"
  name = "api-nodes-group"
  policies = ["anti-affinity"]
}

resource "openstack_compute_instance_v2" "server" {
  name              = "${var.name}${count.index + 1}"
  count             = var.instance_numbers
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  availability_zone = var.server_az
  image_id          = data.openstack_images_image_v2.vm_image.id

  network {
    uuid        = var.first_network_id
    name        = var.first_network_name
    fixed_ip_v4 = "${var.first_ip_subnet}${count.index + var.first_start_ip}"
  }

  dynamic "network" {
    for_each = var.second_ip_subnet != "" ? [var.second_network_id] : []
    content {
      uuid        = var.second_network_id
      name        = var.second_network_name
      fixed_ip_v4 = "${var.second_ip_subnet}${count.index + var.second_start_ip}"
    }
  }

  dynamic "block_device" {
    for_each            = var.volume_size > 0 ? [var.image] : []
    content {
      uuid              = data.openstack_images_image_v2.vm_image.id
      source_type       = "image"
      destination_type  = "volume"
      boot_index        = 0
      volume_size       = var.volume_size
      delete_on_termination = true
    }
  }

  dynamic "scheduler_hints" {
    for_each = var.use_anti_affinity ? [openstack_compute_servergroup_v2.api_nodes[0]] : []
    content {
      group = openstack_compute_servergroup_v2.api_nodes[0].id
    }
  }

  vendor_options {
    ignore_resize_confirmation  = true
  }

  lifecycle {
    ignore_changes = [
      block_device,
      key_pair,
      image_id
    ]
  }
}
