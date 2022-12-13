resource "azurerm_resource_group" "dns_rg" {
  name     = var.dns_resource_group_name
  location = var.location
}

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.dns_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_link" {
  name                  = "acr_vnet_link"
  resource_group_name   = var.dns_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_zone" "aks_private_dns_zone" {
  name                = "privatelink.${var.location}.azmk8s.io"
  resource_group_name = azurerm_resource_group.dns_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_link" {
  name                  = "aks_vnet_link"
  resource_group_name   = azurerm_resource_group.dns_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.aks_private_dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_zone" "keyvault_private_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dns_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault_link" {
  name                  = "keyvault_vnet_link"
  resource_group_name   = azurerm_resource_group.dns_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault_private_dns_zone.name
  virtual_network_id    = var.vnet_id
}
resource "azurerm_private_dns_zone" "blob_private_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.dns_rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_link" {
  name                  = "blob_vnet_link"
  resource_group_name   = azurerm_resource_group.dns_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.blob_private_dns_zone.name
  virtual_network_id    = var.vnet_id
}
