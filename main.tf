module "network" {
  source = "./modules/network"

  location                    = var.location
  network_resource_group_name = var.network_resource_group_name
  network_watcher_name        = var.network_watcher_name
  vnet_name                   = var.vnet_name
  vnet_address_space          = var.vnet_address_space
  bastion_name                = var.bastion_name
  subnet_names                = var.subnet_names
  subnet_prefixes             = var.subnet_prefixes
}

module "dns" {
  source = "./modules/dns"

  location                = var.location
  dns_resource_group_name = var.dns_resource_group_name
  vnet_id                 = module.network.vnet_id
}