variable "req_tags" {
  type = object({
    environment_tag = string
    solution_tag    = string
    owner_tag       = string
    department_tag  = string
  })
  default = {
    department_tag  = "information technology"
    environment_tag = "shared"
    owner_tag       = "system services"
    solution_tag    = "vwan"
  }
}

variable "location" {
  default = "northcentralus"
}

variable "vpn_site_names" {
  type = list(string)
  default = [ "vpn-site-neenah-to-azure", "vpn-site-azure-to-dc" ]
}

variable "vpn_addresses_neenah" {
  type = list(string)
  default = ["172.17.0.0/16", "172.18.0.0/16", "172.19.0.0/16", "172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16", "172.31.0.0/16"]
}

variable "vpn_addresses_dc" {
  type = list(string)
  default = [ "value" ]
}

variable "vpn_connection_names" {
  type = list(string)
  default = [ "connection-neenah-to-azure", "connection-azure-to-dc" ]
}

variable "vpn_link_names" {
  type = list(string)
  default = [ "link-neenah-to-azure", "link-azure-to-dc" ]
}

variable "secret_map" {
    type = object({
      tfstate-access-key = string
      vwan-psk = string
    })
    default = {
      "tfstate-access-key" = "02eVSWYbx4t8q7s2odhCs/zENMg30AvG8Xmo9fWiGIny5jsBwBMumFFKYZGwnHml4oTLarFTxRy8+ASty3PlIQ==" #"${data.azurerm_storage_account.this.primary_access_key}"
      "vwan-psk" = "TxG7v4sm4rbKNiuJSckYwrHlLFAkNFn0b"
    }
  }

variable "neenah_ipsec" {
  type = object({
    dh_group = string
    ike_encryption_algorithm = string
    ike_integrity_algorithm = string
    encryption_algorithm = string
    integrity_algorithm = string
    pfs_group = string
    sa_data_size_kb = number
    sa_lifetime_sec = number
  })
  default = {
    dh_group = "DHGroup14"
    encryption_algorithm = "AES256"
    ike_encryption_algorithm = "AES256"
    ike_integrity_algorithm = "SHA256"
    integrity_algorithm = "SHA256"
    pfs_group = "PFS24"
    sa_data_size_kb = 102400000
    sa_lifetime_sec = 28800
  }
}

variable "neenah_connection_mode" {
  default = "ResponderOnly"
}

variable "neenah_vpn_protocol" {
  default = "IKEv2"
}

variable "ts_setting" {
  type = list(string)
  default = ["172.17.0.0/16", "172.18.0.0/16", "172.19.0.0/16", "172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16", "172.30.0.0/16", "172.31.0.0/16"]
}



#variable "secret_map" {
#  type = map(string)
#  default = {
#    "tfstate-key" = ""
#  }
#}