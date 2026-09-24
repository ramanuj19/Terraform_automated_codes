variable"postgresql-flexible"{}
variable "databases" {
 }
resource "azurerm_postgresql_flexible_server" "db" {
  for_each = var.postgresql-flexible

  name= each.value.server_name
  resource_group_name    =        each.value.rg_name
  location =                      each.value.location
  administrator_login    =        each.value.admin_user
  administrator_password =        each.value.admin_password
  sku_name               =        "B_Standard_B1ms"
  public_network_access_enabled = true
  storage_mb =                    32768
  version                =    "18"
   lifecycle {
    ignore_changes = [
      zone,
      high_availability
    ]
  }
}

resource "azurerm_postgresql_flexible_server_database" "db_instances" {
  for_each = var.databases

  name      = each.value.db_name
  server_id = azurerm_postgresql_flexible_server.db[each.value.server_key].id
  collation = each.value.collation
  charset   = each.value.charset
  }
