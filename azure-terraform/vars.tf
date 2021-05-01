variable "RG_NAME" {}

variable "RG_LOCATION" {
  type = string
  default = "North Central US"
}

variable "VNET" {
  type = list(object({
    vnet_name     = string
    address_space = list(string)
    subnets = list(object({
      name    = string
      address = string
    }))
  }))
}

variable "ADMIN_USER"{
  type = string
}

variable "VM_SIZE"{
  type = string
}

variable "VM_NAME"{
  type = string
}

variable "PUB_IP_NAME" {
  default = "terraform_ip"
}

variable "NSG_NAME" {
  default = "nsg"
}

variable "PORTS" {
  type = list(object({
    priority = string
    port = string
    }))
}
