resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.n01728463-rgroup
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = local.common_tags
}


resource "azurerm_public_ip" "windows_pip" {
  count               = var.nb_count
  name                = "${var.windows_name}${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  allocation_method   = "Static"
  domain_name_label   = "${var.windows_name}${count.index + 1}"
  tags                = local.common_tags
}


resource "azurerm_network_interface" "windows_nic" {
  count               = var.nb_count
  name                = "${var.windows_name}${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.n01728463-rgroup

  ip_configuration {
    name                          = "${var.windows_name}${count.index + 1}-ipconfig"
    subnet_id                     = var.n01728463-subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[count.index].id
  }

  tags = local.common_tags
}

resource "azurerm_windows_virtual_machine" "vmwindows" {
  count                 = var.nb_count
  name                  = "${var.windows_name}${count.index + 1}"
  location              = var.location
  resource_group_name   = var.n01728463-rgroup
  size                  = var.windows_vm_size
  admin_username        = var.windows_admin_username
  admin_password        = var.windows_admin_password
  network_interface_ids = [azurerm_network_interface.windows_nic[count.index].id]
  availability_set_id   = azurerm_availability_set.windows_avs.id

  os_disk {
    name                 = "${var.windows_name}${count.index + 1}-os-disk"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size
  }

  source_image_reference {
    publisher = var.windows_os.publisher
    offer     = var.windows_os.offer
    sku       = var.windows_os.sku
    version   = var.windows_os.version
  }

  tags = local.common_tags

}

resource "azurerm_virtual_machine_extension" "Antimalware" {
  count                = var.nb_count
  name                 = "IaaSAntimalware"
  virtual_machine_id   = element(azurerm_windows_virtual_machine.vmwindows[*].id, count.index)
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "Exclusions": {
            "Extensions": ".log;.ldf",
            "Paths": "C:\\IISlogs;C:\\CustomFolder",
            "Processes": "mssence.svc"
        },
        "RealtimeProtectionEnabled": true,
        "ScheduledScanSettings": {
            "isEnabled": true,
            "scanType": "Quick",
            "day": "7",
            "time": "120"
        }
    }
  SETTINGS
  tags     = local.common_tags
}
