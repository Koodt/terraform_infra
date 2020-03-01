data "openstack_images_image_v2" "vm_image" {
  name = "${var.image}"
}

resource "openstack_networking_port_v2" "first_port" {
  count         = var.instance_numbers
  name          = "port_${var.hostname}_${count.index}"
  network_id    = var.first_network_id
  fixed_ip {
    ip_address  = "${var.first_ip_subnet}${count.index+10}"
    subnet_id   = var.first_network_subnet_id
  }
}

resource "openstack_networking_port_v2" "second_port" {
  count = var.second_ip != "" ? 1 : 0
  name          = "port_${var.hostname}_2"
  network_id    = var.second_network_id
  fixed_ip {
    ip_address  = var.second_ip
    subnet_id   = var.second_network_subnet_id
  }
}

resource "openstack_compute_instance_v2" "server" {
  name              = "${var.name}${count.index+1}"
  count             = var.instance_numbers
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  availability_zone = var.server_az

  network {
    port = openstack_networking_port_v2.first_port[count.index].id
  }

  dynamic "network" {
    for_each = openstack_networking_port_v2.second_port
    content {
      port = network.value["id"]
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
