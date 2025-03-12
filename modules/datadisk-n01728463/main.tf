resource "azurerm_managed_disk" "n01728463-data-disk" {
  count = var.nb_count
  #name                =  "${var.vm_names}-${format("%1d", count.index + 1)}"
  name                 = "${element(var.vm_names, count.index)}-datadisk-${format("%1d", count.index + 1)}"
  resource_group_name  = var.n01728463-rgroup
  location             = var.location
  storage_account_type = var.storage_account_type
  disk_size_gb         = var.disk_size
  create_option        = var.create_option
  tags                 = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01728463-attach-linux-disk" {
  count              = length(var.vmlinux_ids)
  managed_disk_id    = element(azurerm_managed_disk.n01728463-data-disk[*].id, count.index)
  virtual_machine_id = element(var.vmlinux_ids, count.index)
  lun                = var.lun
  caching            = var.disk_caching
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01728463-attach-windows-disk" {
  count              = length(var.vmwindows_id)
  managed_disk_id    = azurerm_managed_disk.n01728463-data-disk[count.index + 3].id
  virtual_machine_id = element(var.vmwindows_id, count.index)
  lun                = var.lun
  caching            = var.disk_caching
}
