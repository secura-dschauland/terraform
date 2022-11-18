resource "azurerm_key_vault" "this" {
    name = "${module.naming.key_vault.name}-${local.req_tags.environment}-${local.req_tags.solution}"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = data.azurerm_resource_group.rg.location
    tenant_id = "dd5e32e1-ed4d-4a96-955f-eb771563c033"
    sku_name = "standard"
    enable_rbac_authorization = true
  
}

resource "azurerm_key_vault_secret" "this" {
  # the secrets for stuff
  count = length(var.secret_map)
  name = keys(var.secret_map)[count.index]
  value = values(var.secret_map)[count.index]
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [
    azurerm_role_assignment.this
  ]
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "this" {
  scope = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id = "fe584f68-41df-4317-9d8c-37b380fa537d"
}