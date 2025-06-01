output "domain_name" {
  value = libvirt_domain.vm.name
}

output "volume_id" {
  value = libvirt_volume.vm_disk.id
}

