# Each VPN site in the current config should have its own .tf file 
resource "azurerm_vpn_site" "neenah" {
  name                = var.vpn_site_names[0]
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  virtual_wan_id      = azurerm_virtual_wan.vwan.id
  address_cidrs       = var.vpn_addresses_neenah
  device_model        = "ftd"
  device_vendor       = "cisco"

  tags = local.req_tags

  link {
    name          = local.neenah_vpn_site_link_name #"vpn-site-link-neenah-to-azure"
    ip_address    = "98.100.228.4"
    provider_name = "Spectrum"
    speed_in_mbps = 1000
  }
}

resource "azurerm_vpn_gateway_connection" "vpnconnect" {
  name               = var.vpn_connection_names[0]
  vpn_gateway_id     = azurerm_vpn_gateway.gateway.id
  remote_vpn_site_id = azurerm_vpn_site.neenah.id
  

  vpn_link {
    name                                  = var.vpn_link_names[0]
    vpn_site_link_id                      = azurerm_vpn_site.neenah.link[0].id
    policy_based_traffic_selector_enabled = var.neenah_connection_mode == "ResponderOnly" ? false : true


    ipsec_policy {
      dh_group                 = var.neenah_ipsec.dh_group #"DHGroup14"
      ike_encryption_algorithm = var.neenah_ipsec.ike_encryption_algorithm #"AES256"
      ike_integrity_algorithm  = var.neenah_ipsec.ike_integrity_algorithm #"SHA256"
      encryption_algorithm     = var.neenah_ipsec.encryption_algorithm #"AES256"
      integrity_algorithm      = var.neenah_ipsec.integrity_algorithm #"SHA256"
      pfs_group                = var.neenah_ipsec.pfs_group #"PFS24"
      sa_data_size_kb          = var.neenah_ipsec.sa_data_size_kb #102400000
      sa_lifetime_sec          = var.neenah_ipsec.sa_lifetime_sec #28800
    }

    protocol   = var.neenah_vpn_protocol
    shared_key = azurerm_key_vault_secret.this[1].value   #data.azurerm_key_vault_secret.psk.value #get this from key vault
    connection_mode = var.neenah_connection_mode
    
  }
 
}
#resource "azurerm_vpn_gateway_connection" "vpn2dc" {
#  name               = var.connection_names[1]
#  vpn_gateway_id     = azurerm_vpn_gateway.gateway.id
#  remote_vpn_site_id = azurerm_vpn_site.this.id
#
#  vpn_link {
#    name                                  = "link-neenah-to-azure"
#    vpn_site_link_id                      = azurerm_vpn_site.this[each.key].link.id
#    policy_based_traffic_selector_enabled = true
#
#
#    ipsec_policy {
#      dh_group                 = "DHGroup14"
#      ike_encryption_algorithm = "AES256"
#      ike_integrity_algorithm  = "SHA256"
#      encryption_algorithm     = "AES256"
#      integrity_algorithm      = "SHA256"
#      pfs_group                = "PFS24"
#      sa_data_size_kb          = 102400000
#      sa_lifetime_sec          = 28800
#    }
#
#    protocol   = "IKEv2"
#    shared_key = azurerm_key_vault_secret.this[1].value   #data.azurerm_key_vault_secret.psk.value #get this from key vault
#    connection_mode = "ResponderOnly"
#    
#  }
##  traffic_selector_policy {
#    local_address_ranges  = ["172.17.0.0/16", "172.18.0.0/16", "172.19.0.0/16", "172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16", "172.30.0.0/16", "172.31.0.0/16"]
#    remote_address_ranges = ["10.227.0.0/22"]
#  }
#}
