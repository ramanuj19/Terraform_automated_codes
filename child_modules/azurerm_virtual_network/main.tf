variable "vnet" {}
resource "azurerm_virtual_network" "vnetwork" {
  for_each = var.vnet
  name                = each.value.vnet_name
  address_space       = each.value.vnet_address_space
  location            = each.value.vnet_location
  resource_group_name = data.azurerm_resource_group.resource[each.key].name
}