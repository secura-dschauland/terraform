variable "req_tags" {
  type = object({
    solution_tag   = string
    owner_tag      = string
    department_tag = string
  })
  default = {
    department_tag = "information technology"
    owner_tag      = "system services"
    solution_tag   = "iap"
  }
}

variable "location" {
  default = "eastus2"
}

variable "env_specific_tags" {
  type = object({
    environment = string

  })
  default = {
    environment = "prod"
  }
}
