variable "nb_count" {}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "disk_size" {
  default = 10
}

variable "n01728463-rgroup" {}

variable "location" {}

variable "lun" {
  default = 0
}

variable "disk_caching" {
  default = "ReadWrite"
}

variable "vm_names" {
  type = list(string)
}

variable "vmlinux_ids" {}

variable "vmwindows_id" {}

variable "create_option" {
  default = "Empty"
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
  Environment = "Learning" }
}
