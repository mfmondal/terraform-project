resource "azurerm_postgresql_server" "n01728463_db" {
  name                = var.db_server_name
  resource_group_name = var.n01728463-rgroup
  location            = var.location
  sku_name            = var.db_sku
  #storage_mb          = 5120
  version                      = var.db_version
  ssl_enforcement_enabled      = var.ssl_enforcement_enabled
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
}

