
resource "null_resource" "linux_provisioner" {
  #count      = var.nb_count
  for_each   = azurerm_linux_virtual_machine.vmlinux
  depends_on = [azurerm_linux_virtual_machine.vmlinux]

  provisioner "remote-exec" {
    inline = ["/bin/hostname"]

    connection {
      type        = "ssh"
      user        = var.linux_admin_username
      private_key = file(var.priv_key)
      #host        = element(azurerm_linux_virtual_machine.vmlinux[*].public_ip_address, count.index + 1)
      #host = element(azurerm_public_ip.linux_pip[*].ip_address, count.index + 1)
      host = azurerm_linux_virtual_machine.vmlinux[each.key].public_ip_address
    }
  }
}

