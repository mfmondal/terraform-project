
output "windows_availability_set" {
  value = azurerm_availability_set.windows_avs.name
}

output "windows_hostnames" {
  value = azurerm_windows_virtual_machine.vmwindows[*].computer_name
}

output "windows_fqdns" {
  value = azurerm_public_ip.windows_pip[*].fqdn
}

output "windows_private_ip_addresses" {
  value = azurerm_network_interface.windows_nic[*].ip_configuration[0].private_ip_address
}

output "windows_public_ip_addresses" {
  value = azurerm_public_ip.windows_pip[*].ip_address
}

# Output block for VM IDs
output "vmwindows_id" {
  value = azurerm_windows_virtual_machine.vmwindows[*].id
}


