resource "azurerm_api_management" "this" {
  name = "${module.naming.api_management.name}-${local.naming_items}"
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  publisher_name = var.publisher_name
  publisher_email = var.publisher_email

  sku_name = local.sku
  tags = local.req_tags
  

  #aditional location not supported for developer sku
  #additional_location {
  #  location = var.secondary_location
  #  
  #  #zones are the availability zones for the secondary region - only supported for premium sku
  #  #zones =
#
  #  #public ip address id - only supported in premium sku
  #  #public_ip_address_id = 
  #}
identity {
  type = "SystemAssigned"
}

}