variable "firewall_rules" {
  }
data "azurerm_postgresql_flexible_server" "postgres" {
    for_each = var.firewall_rules
  name                = each.value.server_name  # Yahan apne PostgreSQL server ka sahi naam string me likhein
  resource_group_name = each.value.rg_name  # Yahan apne Resource Group ka sahi naam string me likhein
}
