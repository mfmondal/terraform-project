variable "lb-name" {}

variable "n01728463-rgroup" {}

variable "location" {}

variable "vm_names" {
  type = list(string)
}

variable "network_interface_ids" {
  type = list(string)
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
    Environment    = "Learning"
  }
}
