variable "primary_location" {
  default = "northcentralus"
}

variable "secondary_location" {
  default = "southcentralus"
}

variable "publisher_name" {
  default = "Secura"
}

variable "publisher_email" {
  default = "derek_schauland@secura.net"
}

variable "sku_name" {
  default = "Developer"
}

variable "sku_count" {
  default = 1
}

variable "api_display_name" {
  default = "XapiDuckCreek"
}

variable "api_revision" {
  default = "1"
}

variable "req_tags" {
    type = object({
        environment_tag = string
        solution_tag = string
        owner_tag = string
        department_tag = string
    })
    default =  {
      department_tag = ""
      environment_tag = ""
      owner_tag = ""
      solution_tag = ""
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