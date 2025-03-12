resource "azurerm_lb" "n01728463-lb" {
  name                = var.lb-name
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  #sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb-pip.id
  }
}

resource "azurerm_public_ip" "lb-pip" {
  name                = "lb-pip"
  location            = var.location
  resource_group_name = var.n01728463-rgroup
  allocation_method   = "Static"
  tags                = local.common_tags
}

resource "azurerm_lb_backend_address_pool" "lb-backend-pool" {
  name            = "BackEndAddressPool"
  loadbalancer_id = azurerm_lb.n01728463-lb.id
}

resource "azurerm_lb_probe" "lb-probe" {
  name            = "TcpProbe"
  loadbalancer_id = azurerm_lb.n01728463-lb.id
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "lb-rule" {
  name                           = "LBRule"
  loadbalancer_id                = azurerm_lb.n01728463-lb.id
  frontend_ip_configuration_name = azurerm_lb.n01728463-lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb-backend-pool.id]
  probe_id                       = azurerm_lb_probe.lb-probe.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend_association" {
  count                   = length(var.vm_names)
  network_interface_id    = var.network_interface_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-pool.id
}

