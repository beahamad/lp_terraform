# Dynamic Virtualbox laucher
# Author: Ana Hamad
# References: https://registry.terraform.io/providers/terra-farm/virtualbox/latest/docs/resources/vm

terraform {
  required_providers {
    virtualbox = {
      source   = "terra-farm/virtualbox"
      version  = "0.2.2-alpha.1"
    }
  }
}

resource "virtualbox_vm" "node" {
  count     = var.vm_count <= var.setup[var.vm_size].max ? var.vm_count : 0
  name      = format("${var.vm_name}-%02d", count.index + 1)
  image     = var.vm_image
  cpus      = var.setup[var.vm_size].vm_cpus
  memory    = var.setup[var.vm_size].vm_mem
  # user_data = file("${path.module}/user_data")

  network_adapter {
    type           = var.net_type
    host_interface = "vboxnet0"
  }
}