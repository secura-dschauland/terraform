resource "azurerm_api_management_api" "this" {
  name                = "api-${local.naming_items}"
  resource_group_name = azurerm_resource_group.this.name
  api_management_name = azurerm_api_management.this.name

  revision     = var.api_revision
  display_name = var.api_display_name
  protocols    = ["http"]


  import {
    content_format = "openapi+json-link"
    content_value  = azurerm_storage_blob.this.url
  }

  depends_on = [
    azurerm_storage_blob.this
  ]
}





#resource "azurerm_api_management_api_policy" "this" {
#  api_name = azurerm_api_management_api.this.name
#  api_management_name = azurerm_api_management_api.this.api_management_name
#  resource_group_name = azurerm_api_management_api.this.resource_group_name
#
#  xml_content = <<XML
#<policies>
#    <inbound>
#        <base />
#        <set-backend-service backend-id="XapiDuckCreek" />
#        <!-- Variables needed for Policy Fragment -->
#        <set-variable name="client-id" value="@(context.Request.Headers.GetValueOrDefault("client-id"))" />
#        <set-variable name="client-secret" value="@(context.Request.Headers.GetValueOrDefault("client-secret"))" />
#        <set-variable name="api-client-id" value="{{DuckCreek-Xapi-Client-ID}}" />
#        <set-variable name="api-scope" value="{{DuckCreek-Xapi-Scope}}" />
#        <set-variable name="api-role" value="access" />
#        <!-- Policy Fragment -->
#        <include-fragment fragment-id="Inbound-OAuth" />
#        <!-- Removal of unnecessary headers to the backend -->
#        <set-header name="client-id" exists-action="delete" />
#        <set-header name="client-secret" exists-action="delete" />
#    </inbound>
#    <backend>
#        <base />
#    </backend>
#    <outbound>
#        <base />
#        <set-header name="x-powered-by" exists-action="delete" />
#    </outbound>
#    <on-error>
#        <base />
#    </on-error>
#</policies>
#  XML
#
#  depends_on = [
#    azurerm_api_management_named_value.this
#  ]
#}
