
# Output block for Availability Set
output "availability_set" {
  value = azurerm_availability_set.linux_avs.name
}

# Output block for Hostnames
output "linux_vm_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.vmlinux : vm.name]
}

# Output block for FQDNs
output "linux_vm_fqdns" {
  value = flatten([for pip in azurerm_public_ip.linux_pip : pip.fqdn])
}

# Output block for Private IP Addresses
output "linux_private_ip_addresses" {
  value = flatten([for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].private_ip_address])
}

# Output block for Public IP Addresses
output "linux_public_ip_addresses" {
  value = flatten([for pip in azurerm_public_ip.linux_pip : pip.ip_address])
}

# Output block for VM IDs
output "vmlinux_ids" {
  value = [for vm in azurerm_linux_virtual_machine.vmlinux : vm.id]
}

# Output block for Netwotk IDs
output "linux_network_ids" {
  #value = [for vm in azurerm_linux_virtual_machine.vmlinux:vm.id]
  value = values(azurerm_network_interface.linux_nic)[*].id
}

