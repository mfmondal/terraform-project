variable "log-workspace" {}

variable "location" {}

variable "n01728463-rgroup" {}

variable "recovery-vault" {}

variable "storage-acct" {}

variable "account-tier" {
  default = "Standard"
}

variable "account-replication-type" {
  default = "LRS"
}

variable "sku" {
  default = "Standard"
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
    Environment    = "Learning"
  }
}
