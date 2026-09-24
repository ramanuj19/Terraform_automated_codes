  
  resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  for_each         = var.firewall_rules

  name             = each.value.name
  
  start_ip_address = "106.222.249.47"
  end_ip_address   = "106.222.249.47"

  server_id        = data.azurerm_postgresql_flexible_server.postgres[each.key].id
  }
