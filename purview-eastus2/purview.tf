resource "azurerm_purview_account" "this" {
  name                = "pv-${local.req_tags.solution}-${local.environment_tags.environment}-${local.location}"
  resource_group_name = azurerm_resource_group.res-0.name
  location            = azurerm_resource_group.res-0.location

  identity {
    type = "SystemAssigned"
  }

  managed_resource_group_name = "${module.naming.resource_group.name}-managed-${local.req_tags.solution}-${local.environment_tags.environment}-${local.location}" #"rg-iap-purview-managed-eastus2"
  tags                        = local.tags

}
