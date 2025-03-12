output "datadisk-names" {
  value = [for i in range(4) : azurerm_managed_disk.n01728463-data-disk[i].name]
}
