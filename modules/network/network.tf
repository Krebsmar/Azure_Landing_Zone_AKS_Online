resource "azurerm_resource_group" "network_rg" {
  name     = var.network_resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "aks_vnet" {
  address_space       = var.k8s_vnet_address_space
  location            = var.location
  name                = var.k8s_vnet_name
  resource_group_name = azurerm_resource_group.network_rg.name
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/27"]
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "examplepip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "k8s_bastion" {
  name                = "examplebastion"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_subnet" "gateway_subnet" {
  address_prefixes     = var.gateway_subnet_address_prefixes
  name                 = var.gateway_subnet_name
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}

resource "azurerm_subnet" "ingress_subnet" {
  address_prefixes     = var.ingress_subnet_address_prefixes
  name                 = var.ingress_subnet_name
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}

resource "azurerm_subnet" "k8s_subnet" {
  address_prefixes     = var.k8s_subnet_address_prefixes
  name                 = var.k8s_subnet_name
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}

resource "azurerm_subnet" "endpoint_subnet" {
  address_prefixes     = var.endpoint_subnet_address_prefixes
  name                 = var.endpoint_subnet_name
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
}