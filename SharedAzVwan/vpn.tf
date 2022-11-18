resource "azurerm_vpn_site" "this" {
  name                = "vpn-site-azure-to-neenah"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_cidrs       = ["172.17.0.0/16", "172.18.0.0/16", "172.19.0.0/16", "172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16", "172.31.0.0/16"] #on-prem cidrs
  device_model        = "ftd"
  device_vendor       = "cisco"

  tags = local.req_tags

  link {
    name          = "vpn-link-az2neenah"
    ip_address    = "98.100.228.4"
    provider_name = "Spectrum"
    speed_in_mbps = 1000
  }
}

resource "azurerm_vpn_gateway_connection" "vpnconnection" {
  name               = "connection-neenah-to-azure"
  vpn_gateway_id     = azurerm_vpn_gateway.gateway.id
  remote_vpn_site_id = azurerm_vpn_site.this.id

  vpn_link {
    name                                  = "link-neenah-to-azure"
    vpn_site_link_id                      = azurerm_vpn_site.this.link[0].id
    policy_based_traffic_selector_enabled = true


    ipsec_policy {
      dh_group                 = "DHGroup14"
      ike_encryption_algorithm = "AES256"
      ike_integrity_algorithm  = "SHA256"
      encryption_algorithm     = "AES256"
      integrity_algorithm      = "SHA256"
      pfs_group                = "PFS24"
      sa_data_size_kb          = 102400000
      sa_lifetime_sec          = 28800
    }

    protocol   = "IKEv2"
    shared_key = data.azurerm_key_vault_secret.psk.value #get this from key vault
    connection_mode = "ResponderOnly"
    
  }
#  traffic_selector_policy {
#    local_address_ranges  = ["172.17.0.0/16", "172.18.0.0/16", "172.19.0.0/16", "172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16", "172.30.0.0/16", "172.31.0.0/16"]
#    remote_address_ranges = ["10.227.0.0/22"]
#  }
}
