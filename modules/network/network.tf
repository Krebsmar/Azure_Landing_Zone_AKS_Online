resource "azurerm_resource_group" "network_rg" {
  name     = var.network_resource_group_name
  location = var.location
}

resource "azurerm_network_watcher" "network_watcher" {
  name                = var.network_watcher_name
  location            = var.location
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_virtual_network" "aks_vnet" {
  address_space       = var.vnet_address_space
  location            = var.location
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.network_rg.name

  depends_on = [azurerm_network_watcher.network_watcher]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.0.0/27"]
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion_pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.network_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "k8s_bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = azurerm_resource_group.network_rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_subnet" "subnet" {
  count                                          = length(var.subnet_names)
  name                                           = var.subnet_names[count.index]
  resource_group_name                            = azurerm_resource_group.network_rg.name
  virtual_network_name                           = azurerm_virtual_network.aks_vnet.name
  address_prefixes                               = [var.subnet_prefixes[count.index]]
}