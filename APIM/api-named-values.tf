resource "azurerm_api_management_named_value" "this" {
  name                = "nv-duck-creek-xapi-clientid"
  resource_group_name = azurerm_api_management.this.resource_group_name
  api_management_name = azurerm_api_management.this.name

  display_name = "DuckCreek-Xapi-Client-ID"
  value        = "0ad9d006-f235-46db-af60-11f4a7cebd23"
  secret       = true

  depends_on = [
    azurerm_api_management.this,
    azurerm_api_management_api.this
  ]
}
