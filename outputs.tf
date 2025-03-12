output "Resource-Group" {
  value = module.rgroup-n01728463.rgroup-n01728463
}

output "Virtual-network" {
  value = module.network-n01728463.n01728463-vnet
}

output "Subnet" {
  value = module.network-n01728463.n01728463-subnet
}

output "Log-Analytics-Workspace" {
  value = module.common-n01728463.log-workspace
}

output "Recovery-Services-Vault" {
  value = module.common-n01728463.recovery-vault
}

output "Storage-Account" {
  value = module.common-n01728463.storage-acct
}

output "linux_public_ip_address" {
  value = module.vmlinux-n01728463.linux_public_ip_addresses
}

output "linux_private_ip_addresses" {
  value = module.vmlinux-n01728463.linux_private_ip_addresses
}

output "availability_set" {
  value = module.vmlinux-n01728463.availability_set
}

# Output block for VM hostname
output "linux_vm_hostnames" {
  value = module.vmlinux-n01728463.linux_vm_hostnames

}

# Output block for VM FQDN
output "linux_vm_fqdns" {
  value = module.vmlinux-n01728463.linux_vm_fqdns
}

output "windows-availability-set" {
  value = module.vmwindows-n01728463.windows_availability_set
}

output "windows-hostname" {
  value = module.vmwindows-n01728463.windows_hostnames
}

output "windows-fqdn" {
  value = module.vmwindows-n01728463.windows_fqdns
}

output "windows-private-ip-address" {
  value = module.vmwindows-n01728463.windows_private_ip_addresses
}

output "windows-public-ip-address" {
  value = module.vmwindows-n01728463.windows_public_ip_addresses
}

output "datadisk-names" {
  value = module.datadisk-n01728463.datadisk-names
}


output "lb-name" {
  value = module.loadbalancer-n01728463.lb-name
}

output "db_server_name" {
  value = module.database-n01728463.db_server_name
}
