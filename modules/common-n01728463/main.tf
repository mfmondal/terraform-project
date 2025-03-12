# Resource block for log analytics workspace
resource "azurerm_log_analytics_workspace" "n01728463-log-workspace" {
  name                = var.log-workspace
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  tags                = local.common_tags
}

# Resource block for recovery service vault
resource "azurerm_recovery_services_vault" "n01728463-recovery-vault" {
  name                = var.recovery-vault
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  sku                 = var.sku
  tags                = local.common_tags
}

# Resource block for storage account
resource "azurerm_storage_account" "n01728463-storage-acct" {
  name                     = var.storage-acct
  resource_group_name      = var.n01728463-rgroup
  location                 = var.location
  account_tier             = var.account-tier
  account_replication_type = var.account-replication-type
  tags                     = local.common_tags
}

