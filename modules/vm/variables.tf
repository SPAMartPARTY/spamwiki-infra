variable "name" {}
variable "memory" { default = 2048 }
variable "vcpus"  { default = 2 }
variable "pool"   { default = "default" }
variable "image_url" {}
variable "network"   { default = "default" }
variable "machine"   { default = "pc" }
variable "ssh_authorized_key" {
  description = "The SSH public key to add to the VM"
  type        = string
}

variable "mac_address" {
  type        = string
  description = "Static MAC address for consistent DHCP assignment"
}


#variable "pool_path" {
#  description = "Absolute path to the storage pool directory"
#  type        = string
#}
