terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01728463RG"
    storage_account_name = "tfstaten01728463sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
