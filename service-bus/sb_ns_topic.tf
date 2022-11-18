resource "azurerm_servicebus_topic" "this" {
  name         = "${module.naming.servicebus_topic.name}-${local.naming_items}"
  namespace_id = azurerm_servicebus_namespace.this.id

  support_ordering          = true
  enable_batched_operations = true
  max_size_in_megabytes     = 1024
  default_message_ttl       = "P14D"

}