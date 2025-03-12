variable "linux_avs" {}

variable "nb_count" {}

variable "linux_name" {
  type = map(string)
  default = {
    n01728463-c-vm1 = "Standard_B1s"
    n01728463-c-vm2 = "Standard_B1s"
    n01728463-c-vm3 = "Standard_B1s"
  }
}
variable "vm_size" {}

variable "linux_admin_username" {}

variable "pub_key" {}

variable "priv_key" {}

variable "storage_account_type" {}

variable "disk_caching" {}

variable "disk_size" {}

variable "linux_publisher" {}

variable "linux_offer" {}

variable "linux_sku" {}

variable "linux_version" {}

variable "n01728463-rgroup" {}

variable "location" {}

variable "n01728463-subnet" {}

variable "boot_diagnostics_storage_account_uri" {}

locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "foyzer.mondal"
    ExpirationDate = "2025-12-31"
    Environment    = "Learning"
  }
}
