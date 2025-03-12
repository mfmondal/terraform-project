output "log-workspace" {
  value = azurerm_log_analytics_workspace.n01728463-log-workspace.name
}

output "recovery-vault" {
  value = azurerm_recovery_services_vault.n01728463-recovery-vault.name
}

output "storage-acct" {
  value = azurerm_storage_account.n01728463-storage-acct.name
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.n01728463-storage-acct.primary_blob_endpoint
}
