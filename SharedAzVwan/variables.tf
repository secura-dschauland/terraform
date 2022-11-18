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
