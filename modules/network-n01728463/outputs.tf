# Output block for Virtual Network
output "n01728463-vnet" {
  value = azurerm_virtual_network.N01728463-VNET.name
}

# Output block for Virtual Address Space
output "n01728463-vnet-address-space" {
  value = azurerm_virtual_network.N01728463-VNET.address_space
}

# Output block for Subnet name
output "n01728463-subnet" {
  value = azurerm_subnet.N01728463-SUBNET.name
}

# Output block for Subnet ID
output "n01728463-subnet-id" {
  value = azurerm_subnet.N01728463-SUBNET.id
}

# Output block for Subnet Address prefixes
output "n01728463-subnet-address-prefixes" {
  value = azurerm_subnet.N01728463-SUBNET.address_prefixes
}

# Output block for network security group 
output "n01728463-nsg" {
  value = azurerm_network_security_group.N01728463-NSG.name
}
