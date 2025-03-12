# block for virtual network
variable "n01728463-vnet" {}

# block for virtual network address space
variable "n01728463-vnet-address-space" {}

# block for subnet
variable "n01728463-subnet" {}

# block for subnet1 address spaces
variable "n01728463-subnet-address-prefixes" {}

# block for network security group
variable "n01728463-nsg" {}

# block for resource group
variable "n01728463-rgroup" {}

# block for location
variable "location" {}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
    Environment    = "Learning"
  }
}
