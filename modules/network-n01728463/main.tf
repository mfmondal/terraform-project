# Resource Group
resource "azurerm_virtual_network" "N01728463-VNET" {
  name                = var.n01728463-vnet
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  address_space       = var.n01728463-vnet-address-space
  tags                = local.common_tags
}


# Subnet
resource "azurerm_subnet" "N01728463-SUBNET" {
  name                 = var.n01728463-subnet
  resource_group_name  = var.n01728463-rgroup
  virtual_network_name = azurerm_virtual_network.N01728463-VNET.name
  address_prefixes     = var.n01728463-subnet-address-prefixes

}

# Security Group
resource "azurerm_network_security_group" "N01728463-NSG" {
  name                = var.n01728463-nsg
  location            = var.location
  resource_group_name = var.n01728463-rgroup

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule4"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


# Association
resource "azurerm_subnet_network_security_group_association" "n01728463-association" {
  subnet_id                 = azurerm_subnet.N01728463-SUBNET.id
  network_security_group_id = azurerm_network_security_group.N01728463-NSG.id
}
