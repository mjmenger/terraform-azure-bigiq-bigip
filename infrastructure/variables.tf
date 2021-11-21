# must select a region that supports availability zones
# https://docs.microsoft.com/en-us/azure/availability-zones/az-overview
variable "region" {
    default = "westus2"
}

variable "azs" {
    default = ["1","3"]
}

variable "cidr" {
    default = "10.0.0.0/16"
}

variable "allowed_mgmt_cidr" {
    default = "127.0.0.1/32"
}

variable "environment" {
    default = "demo"
}

variable "prefix" {
    default = "mjmtfdemo"
}