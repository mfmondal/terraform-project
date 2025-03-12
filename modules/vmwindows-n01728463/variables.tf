variable "windows_avs" {
  default = "windows-avs"
}

variable "nb_count" {}

variable "windows_name" {}

variable "windows_vm_size" {}

variable "windows_admin_username" {}

variable "windows_admin_password" {}

variable "os_disk" {
  type = object({
    storage_account_type = string
    disk_size            = number
    caching              = string
  })
  default = {
    storage_account_type = "Premium_LRS"
    disk_size            = 128
    caching              = "ReadWrite"
  }
}

variable "windows_os" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# block for subnet
variable "n01728463-subnet" {}

# block for resource group
variable "n01728463-rgroup" {}

# block for location
variable "location" {}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
  Environment = "Learning" }
}
