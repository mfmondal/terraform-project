# Resource Group Module
module "rgroup-n01728463" {
  source           = "./modules/rgroup-n01728463"
  n01728463-rgroup = "N01728463-RG"
  #location   = "canadacentral"
  tags = local.common_tags
}

# Network Module
module "network-n01728463" {
  source = "./modules/network-n01728463"
  #n01728463-rgroup                    = module.n01728463-network.n01728463-rgroup
  #n01728463-rgroup                  = "N01728463-RG"
  n01728463-rgroup                  = module.rgroup-n01728463.rgroup-n01728463
  location                          = "Canada Central"
  n01728463-vnet                    = "N01728463-VNET"
  n01728463-vnet-address-space      = ["10.0.0.0/16"]
  n01728463-subnet                  = "N01728463-SUBNET"
  n01728463-nsg                     = "network_nsg1"
  n01728463-subnet-address-prefixes = ["10.0.0.0/24"]
}

# Common Module
module "common-n01728463" {
  source           = "./modules/common-n01728463"
  n01728463-rgroup = module.rgroup-n01728463.rgroup-n01728463
  location         = "Canada Central"
  log-workspace    = "N01728463-Log-Analytics-Workspace"
  recovery-vault   = "N01728463-Recovery-Services-Vault"
  storage-acct     = "n01728463storageacct"
}


# Linux Module
module "vmlinux-n01728463" {
  source               = "./modules/vmlinux-n01728463"
  linux_avs            = "linux_avs"
  n01728463-rgroup     = module.rgroup-n01728463.rgroup-n01728463
  location             = "Canada Central"
  storage_account_type = "Premium_LRS"
  disk_size            = "32"
  disk_caching         = "ReadWrite"
  n01728463-subnet     = module.network-n01728463.n01728463-subnet-id
  nb_count             = 3
  #linux_name           = "n01728463-c-vm"
  vm_size                              = "Standard_B1s"
  linux_admin_username                 = "n01728463"
  pub_key                              = "/home/n01728463/.ssh/id_rsa.pub"
  priv_key                             = "/home/n01728463/.ssh/id_rsa"
  linux_publisher                      = "OpenLogic"
  linux_offer                          = "CentOS"
  linux_sku                            = "8_2"
  linux_version                        = "latest"
  boot_diagnostics_storage_account_uri = module.common-n01728463.storage_account_primary_blob_endpoint
}


# Windows Module
module "vmwindows-n01728463" {
  source = "./modules/vmwindows-n01728463"
  #resource_group    = module.resource_group.rg_windows
  #n01728463-rgroup = "N01728463-RG"
  n01728463-rgroup       = module.rgroup-n01728463.rgroup-n01728463
  location               = "Canada Central"
  n01728463-subnet       = module.network-n01728463.n01728463-subnet-id
  nb_count               = 1
  windows_name           = "n01728463-w-vm"
  windows_vm_size        = "Standard_B1s"
  windows_admin_username = "winadm"
  windows_admin_password = "Winadm!23"
}

# Data Disk Module
module "datadisk-n01728463" {
  source           = "./modules/datadisk-n01728463"
  n01728463-rgroup = module.rgroup-n01728463.rgroup-n01728463
  location         = "Canada Central"
  nb_count         = 4
  vm_names         = concat(module.vmlinux-n01728463.linux_vm_hostnames, module.vmwindows-n01728463.windows_hostnames)
  vmlinux_ids      = module.vmlinux-n01728463.vmlinux_ids
  vmwindows_id     = module.vmwindows-n01728463.vmwindows_id
}


# Data Load Balancer
module "loadbalancer-n01728463" {
  source                = "./modules/loadbalancer-n01728463"
  n01728463-rgroup      = module.rgroup-n01728463.rgroup-n01728463
  location              = "Canada Central"
  lb-name               = "Assignment-lb"
  vm_names              = module.vmlinux-n01728463.linux_vm_hostnames
  network_interface_ids = module.vmlinux-n01728463.linux_network_ids

}

module "database-n01728463" {
  source           = "./modules/database-n01728463"
  n01728463-rgroup = module.rgroup-n01728463.rgroup-n01728463
  location         = "Canada Central"
  admin_username   = "admin123"
  admin_password   = "Passwd123"
  db_server_name   = "n01728463-postgresql-server"
  db_sku           = "B_Gen5_2"
  db_version       = "11"
}

