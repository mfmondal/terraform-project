variable "n01728463-rgroup" {}

variable "location" {}

variable "admin_username" {}

variable "admin_password" {}

variable "db_server_name" {}

variable "db_sku" {}

variable "db_version" {}

variable "ssl_enforcement_enabled" {
  default = true
}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
    Environment    = "Learning"
  }
}
