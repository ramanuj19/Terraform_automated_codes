variable "pip" {
  
}
resource "azurerm_public_ip" "pubip" {
  for_each = var.pip
  name                = each.value.pip_name
  location            = each.value.pip_location
  resource_group_name = each.value.rg_name
  allocation_method   = each.value.pip_allocation_method
  sku                 = each.value.pip_sku
}