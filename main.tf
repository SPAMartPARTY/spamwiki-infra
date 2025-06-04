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



module "meatartbot_vm" {
  source    = "./modules/vm"
  name      = "meatartbot"
  memory    = 4096
  vcpus     = 2
  image_url = var.image_url
  pool      = var.pool
  network   = var.network
  #ssh_authorized_key = file("~/.ssh/meatartbot.pub")
  ssh_authorized_key = file("${path.module}/meatartbot.pub")
  #ssh_key  = file("~/.ssh/meatartbot.pub")
  mac_address = "52:54:00:c6:38:81"
  #pool_path  = "/home/perfesser/libvirt-images"

}

# Repeat for other VMs:
module "ollama_vm" {
  source      = "./modules/vm"
  name        = "ollama"
  memory      = 8192
  vcpus       = 4
  image_url   = var.image_url
  pool        = var.pool
  network     = var.network
  mac_address = "52:54:00:86:74:ec"
  #ssh_authorized_key = file("~/.ssh/meatartbot.pub")
  ssh_authorized_key = file("${path.module}/meatartbot.pub")
  #ssh_key  = file("~/.ssh/meatartbot.pub")
  #pool_path  = "/home/perfesser/libvirt-images"

}

