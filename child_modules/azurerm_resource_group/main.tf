variable "rg"{}

resource "azurerm_resource_group" "resource" {
for_each = var.rg
name = each.value.rg_name
location = each.value.rg_location
}
