resource "azurerm_api_management_group_user" "res-17" {
  api_management_name = "apim-ServiceBusPOC-nocnus-001"
  group_name          = "administrators"
  resource_group_name = "rg-ServiceBusPOC-nocnus-001"
  user_id             = "1"
  timeouts {
  }
}
resource "azurerm_api_management_group_user" "res-19" {
  api_management_name = "apim-ServiceBusPOC-nocnus-001"
  group_name          = "developers"
  resource_group_name = "rg-ServiceBusPOC-nocnus-001"
  user_id             = "1"
  timeouts {
  }
}
resource "azurerm_servicebus_namespace" "res-69" {
  capacity                      = 1
  local_auth_enabled            = true
  location                      = "northcentralus"
  minimum_tls_version           = "1.2"
  name                          = "sb-ServiceBusPOC-nocnus-001"
  public_network_access_enabled = true
  resource_group_name           = "rg-ServiceBusPOC-nocnus-001"
  sku                           = "Premium"
  tags = {
    Owner       = "SL300"
    Solution    = "ServiceBus POC"
    environment = "non-production"
  }
  zone_redundant = false
  timeouts {
  }
}
resource "azurerm_servicebus_namespace_authorization_rule" "res-70" {
  listen       = true
  manage       = true
  name         = "RootManageSharedAccessKey"
  namespace_id = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/resourceGroups/rg-ServiceBusPOC-nocnus-001/providers/Microsoft.ServiceBus/namespaces/sb-ServiceBusPOC-nocnus-001"
  send         = true
  timeouts {
  }
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-71,
  ]
}
resource "azurerm_servicebus_namespace_network_rule_set" "res-71" {
  default_action                = "Allow"
  ip_rules                      = []
  namespace_id                  = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/resourceGroups/rg-ServiceBusPOC-nocnus-001/providers/Microsoft.ServiceBus/namespaces/sb-ServiceBusPOC-nocnus-001"
  public_network_access_enabled = true
  trusted_services_allowed      = false
  timeouts {
  }
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-71,
  ]
}
resource "azurerm_servicebus_topic" "res-72" {
  auto_delete_on_idle                     = "P10675199DT2H48M5.4775807S"
  default_message_ttl                     = "P14D"
  duplicate_detection_history_time_window = "PT10M"
  enable_batched_operations               = true
  enable_express                          = false
  enable_partitioning                     = false
  max_message_size_in_kilobytes           = 1024
  max_size_in_megabytes                   = 1024
  name                                    = "paymentack_topic"
  namespace_id                            = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/resourceGroups/rg-ServiceBusPOC-nocnus-001/providers/Microsoft.ServiceBus/namespaces/sb-ServiceBusPOC-nocnus-001"
  requires_duplicate_detection            = false
  status                                  = "Active"
  support_ordering                        = true
  timeouts {
  }
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-71,
  ]
}
resource "azurerm_servicebus_subscription" "res-73" {
  auto_delete_on_idle                       = "P10675198DT2H48M5S"
  client_scoped_subscription_enabled        = false
  dead_lettering_on_filter_evaluation_error = false
  dead_lettering_on_message_expiration      = true
  default_message_ttl                       = "P14D"
  enable_batched_operations                 = true
  forward_dead_lettered_messages_to         = ""
  forward_to                                = ""
  lock_duration                             = "PT2M"
  max_delivery_count                        = 3
  name                                      = "pasub"
  requires_session                          = false
  status                                    = "Active"
  topic_id                                  = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/resourceGroups/rg-ServiceBusPOC-nocnus-001/providers/Microsoft.ServiceBus/namespaces/sb-ServiceBusPOC-nocnus-001/topics/paymentack_topic"
  timeouts {
  }
  depends_on = [
    azurerm_servicebus_topic.res-72,
  ]
}
resource "azurerm_servicebus_subscription_rule" "res-74" {
  action          = ""
  filter_type     = "SqlFilter"
  name            = "$Default"
  sql_filter      = "1=1"
  subscription_id = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/resourceGroups/rg-ServiceBusPOC-nocnus-001/providers/Microsoft.ServiceBus/namespaces/sb-ServiceBusPOC-nocnus-001/topics/paymentack_topic/subscriptions/pasub"
  timeouts {
  }
  depends_on = [
    azurerm_servicebus_subscription.res-73,
  ]
}
resource "azurerm_api_connection" "res-75" {
  display_name        = "dr03578@intranet.secura.net"
  managed_api_id      = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/providers/Microsoft.Web/locations/northcentralus/managedApis/azureeventgrid"
  name                = "azureeventgrid"
  parameter_values    = {}
  resource_group_name = "rg-ServiceBusPOC-nocnus-001"
  tags = {
    Owner       = "SL300"
    Solution    = "ServiceBus POC"
    environment = "non-production"
  }
  timeouts {
  }
}
resource "azurerm_api_connection" "res-76" {
  display_name        = "dr03578@intranet.secura.net"
  managed_api_id      = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/providers/Microsoft.Web/locations/northcentralus/managedApis/office365"
  name                = "office365"
  parameter_values    = {}
  resource_group_name = "rg-ServiceBusPOC-nocnus-001"
  tags = {
    Owner       = "SL300"
    Solution    = "ServiceBus POC"
    environment = "non-production"
  }
  timeouts {
  }
}
resource "azurerm_api_connection" "res-77" {
  display_name        = "PaymentAcknowledgement"
  managed_api_id      = "/subscriptions/737acae0-f9d8-421f-bddb-3c7ee659a32c/providers/Microsoft.Web/locations/northcentralus/managedApis/servicebus"
  name                = "servicebus"
  parameter_values    = {}
  resource_group_name = "rg-ServiceBusPOC-nocnus-001"
  tags = {
    Owner       = "SL300"
    Solution    = "ServiceBus POC"
    environment = "non-production"
  }
  timeouts {
  }
}
