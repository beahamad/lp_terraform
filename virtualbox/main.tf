resource "virtualbox_vm" "node" {
  count     = var.vm_count
  name      = format("${var.vm_name}-%02d", count.index + 1)
  image     = var.vm_image
  cpus      = 2
  memory    = "512 mib"
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = var.network_type
  }
}