resource "azurerm_virtual_wan" "vwan" {
  name                = var.req_tags.solution_tag != "" ? "${module.naming.virtual_wan.name}-${local.naming_items2}" : "${module.naming.virtual_wan.name}-${local.naming_items}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.req_tags
}
