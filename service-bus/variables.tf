variable "req_tags" {
  type = object({
    environment_tag = string
    solution_tag    = string
    owner_tag       = string
    department_tag  = string
  })
  default = {
    department_tag  = ""
    environment_tag = ""
    owner_tag       = ""
    solution_tag    = ""
  }
}

variable "location" {
  default = "northcentralus"
}

variable "sb_sku" {
  default = "Standard"
}

variable "capacity" {
  default = 1

}

variable "subscription_id" {
  default = "96d43cad-de7d-4a42-9939-119278764bf7"
}

variable "logic_app_name" {
  type    = list(string)
  default = []
}
