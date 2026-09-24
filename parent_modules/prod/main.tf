
module "resource_group" {
  source = "../child_modules/azurerm_resource_group"
  rg     = var.rg
}
module "virtual_network" {
  source     = "../child_modules/azurerm_virtual_network"
  vnet       = var.vnet
  depends_on = [module.resource_group]
}
module "subnet" {
  source     = "../child_modules/azurerm_subnet"
  snet       = var.snet
  depends_on = [module.virtual_network]
}
module "linux_virtual_machine" {
  source     = "../child_modules/azurerm_linux_virtual_machine"
  vm         = var.vm
  depends_on = [module.subnet, module.public_ip]
}
module "public_ip" {
  source     = "../child_modules/azurerm_public_ip"
  pip        = var.pip
  depends_on = [module.resource_group]
}
module "postgresql" {
  source              = "../child_modules/postgresql_flexible_server"
  postgresql-flexible = var.postgresql_flexible
  databases           = var.databases
  depends_on          = [module.resource_group]

}
module "rule" {
  source         = "../child_modules/azurerm_postgresql_flexible_server_firewall_rule"
  firewall_rules = var.firewall_rules
  depends_on     = [module.postgresql]

}
module "nsg_rule" {
  source        = "../child_modules/azurerm_network_security_rule"
  security_rule = var.security_rule
  depends_on    = [module.rule, module.subnet]
}