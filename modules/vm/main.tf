
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}


resource "libvirt_volume" "vm_disk" {
  name   = "${var.name}.qcow2"
  pool   = var.pool
  source = var.image_url
  format = "qcow2"



}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name      = "${var.name}-cloudinit.iso"
  pool      = var.pool
  #user_data = file("${path.module}/cloud-init.cfg")
  user_data      = templatefile("${path.module}/cloud-init.cfg", {
    hostname = var.name
   # ssh_key  = var.ssh_key
  })
}


#resource "null_resource" "fix_permissions" {
#  provisioner "local-exec" {
#    command = <<EOT
#      sudo chown libvirt-qemu:kvm ${var.pool_path}/${var.name}.qcow2
#      sudo chown libvirt-qemu:kvm ${var.pool_path}/${var.name}-cloudinit.iso
#      sudo chmod 644 ${var.pool_path}/${var.name}.*
#    EOT
#  }
#}


resource "libvirt_domain" "vm" {

  #depends_on = [null_resource.fix_permissions]

  name   = var.name
  memory = var.memory
  vcpu   = var.vcpus
  machine = var.machine

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id



  network_interface {
    network_name = var.network
    mac = var.mac_address
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport    = true
  }
}


