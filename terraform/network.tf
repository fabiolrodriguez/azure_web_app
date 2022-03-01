resource "azurerm_network_security_group" "sg" {
  name                = var.sg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = var.subnet1
  }

  subnet {
    name           = "subnet2"
    address_prefix = var.subnet2
    security_group = azurerm_network_security_group.sg.id
  }

  tags = {
    environment = var.environment
  }
}

# resource "azurerm_subnet" "dbsubnet" {
#   name                 = var.db_subnet_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [var.db_subnet]
#   service_endpoints    = ["Microsoft.Sql"]
# }

# resource "azurerm_subnet" "bastion" {
#   name                 = "AzureBastionSubnet"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [var.bastion_subnet]
# }

# resource "azurerm_public_ip" "pubip" {
#   name                = "examplepip"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }