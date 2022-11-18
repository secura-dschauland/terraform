resource "azurerm_servicebus_namespace" "this" {
  name                = "${module.naming.servicebus_namespace.name}-${local.naming_items}"
  location            = local.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.req_tags

  sku = local.sb_sku

  capacity = local.sb_sku == "Premium" ? local.capacity : 0

  zone_redundant = local.sb_sku == "Premium" && local.req_tags.environment == "Production" ? true : false


}
