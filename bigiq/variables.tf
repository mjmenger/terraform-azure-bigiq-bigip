variable resourcegroup_location {}
variable resourcegroup_name {}
variable environment {}
variable azs{
    type = list
}
variable prefix{}
variable cidr{}
variable allowed_mgmt_cidr{}

variable private_subnet_ids{
    type = list
}
variable public_subnet_ids{
    type = list
}
variable management_subnet_ids{
    type = list
}

variable "admin_username" {
    description = "BIG-IP administrative user"
    default     = "mjmenger"
}


variable "specs" {
  default = {
    default = {
      location      = "westus2"
      name_rg       = "demo_bigiq_rg"
      instance_type = "Standard_DS5_v2"
      environment   = "This env is using BIG-IQ"
      owner         = "Mark Menger"
      f5version     = "7.1.003000"
      plan_name     = "f5-bigiq-virtual-edition-byol"
      offer         = "f5-big-iq"
      product       = "f5-big-iq"
      publisher     = "f5-networks"
      sku           = "f5-bigiq-virtual-edition-byol"
      storage_type  = "Premium_LRS"
      virtualnet    = ["10.0.0.0/16"]
      trust         = ["10.0.10.0/24"]
      untrust       = ["10.0.20.0/24"]
      mgmt          = ["10.0.30.0/24"]
      comp_name     = "mybigiq"
    }
  }
}