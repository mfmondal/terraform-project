# Aivailability Set
resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.n01728463-rgroup
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
}

# Public IP
resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.linux_name
  name                = "pip-${each.key}"
  resource_group_name = var.n01728463-rgroup
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "pip-${each.key}--${random_id.dns_suffix.hex}"
}

resource "random_id" "dns_suffix" {
  byte_length = 4
}

# Network Interface
resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.n01728463-rgroup

  ip_configuration {
    #name                          = "${each.key}-ipconfig"
    name                          = "internal"
    subnet_id                     = var.n01728463-subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each            = var.linux_name
  name                = each.key
  resource_group_name = var.n01728463-rgroup
  location            = var.location
  size                = each.value
  #computer_name         = each.key
  admin_username = var.linux_admin_username
  #admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.pub_key)
  }

  os_disk {
    # name                 = "${var.linux_name}-os_disk-${format("%1d", count.index + 1)}"
    name                 = "${each.key}-os_disk"
    disk_size_gb         = var.disk_size
    caching              = var.disk_caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  tags = local.common_tags
}
/*
resource "azurerm_virtual_machine_extension" "LinuxDiagnostic" {
  for_each             = var.linux_name
  name                 = "LinuxDianostic"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "LinuxDianostic"
  type_handler_version = "true"
  depends_on = [azurerm_linux_virtual_machine.vmlinux]
}
*/


resource "azurerm_virtual_machine_extension" "AzureMonitorLinuxAgent" {
  for_each             = var.linux_name
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.7"
  tags                 = local.common_tags
}

resource "azurerm_virtual_machine_extension" "NetworkWatcherAgentLinux" {
  for_each             = var.linux_name
  name                 = "NetworkWatcherAgentLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.vmlinux[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  tags                 = local.common_tags
}
