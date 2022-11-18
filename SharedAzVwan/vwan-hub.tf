resource "azurerm_virtual_hub" "vwan-hub" {
  name                = "${module.naming.virtual_wan.name}-${local.req_tags.environment}-hub"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_prefix      = "10.230.2.0/23"
  tags                = local.req_tags



  #There is a route attribute here at the Virtual WAN hub object that you can use to set IP addresses and next hops if needed
  #route {
  #address_prefixes = ["10.0.0.2/24"]
  #next_hop_ip_address = "10.0.120.1"
  #}
  depends_on = [
    azurerm_virtual_wan.vwan
  ]
}

resource "azurerm_virtual_hub_connection" "vwan-hub-spoke01" {
  name                      = "${module.naming.virtual_wan.name}-hub-conn-${data.azurerm_virtual_network.spoke01.name}"
  virtual_hub_id            = azurerm_virtual_hub.vwan-hub.id
  remote_virtual_network_id = data.azurerm_virtual_network.spoke01.id

  depends_on = [
    azurerm_virtual_hub.vwan-hub
  ]
}

resource "azurerm_vpn_gateway" "gateway" {
  name                = "${module.naming.virtual_network_gateway.name}-${local.naming_items}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_hub_id      = azurerm_virtual_hub.vwan-hub.id

  scale_unit = 2
  tags       = local.req_tags

}
