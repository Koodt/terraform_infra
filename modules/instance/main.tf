resource "openstack_networking_port_v2" "first_port" {
  name          = "port_${var.hostname}_1"
  network_id    = var.first_network_id
  fixed_ip {
    ip_address  = var.first_ip
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

resource "openstack_blockstorage_volume_v3" "volume" {
  count                 = var.volume_size != "" ? 1 : 0
  name                  = "volume_${var.hostname}"
  size                  = var.volume_size
  image_id              = var.image_id
  volume_type           = "${var.volume_type}.${var.server_az}"
  availability_zone     = var.server_az

  lifecycle {
    ignore_changes      = [image_id]
  }
}

resource "openstack_compute_instance_v2" "server" {
  name              = var.fqdn
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  image_id          = var.image_id
  availability_zone = var.server_az

  network {
    port = openstack_networking_port_v2.first_port.id
  }

  dynamic "network" {
    for_each = openstack_networking_port_v2.second_port
    content {
      port = network.value["id"]
    }
  }

  dynamic "block_device" {
    for_each            = openstack_blockstorage_volume_v3.volume
    content {
      uuid              = block_device.value["id"]
      source_type       = "volume"
      destination_type  = "volume"
      boot_index        = 0
      volume_size       = 0
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
