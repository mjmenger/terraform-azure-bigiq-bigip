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
variable instance_type	{ default = "Standard_DS3_v2" }
variable image_name	{ default = ["f5-bigip-virtual-edition-25m-best-hourly","f5-big-all-1slot-byol"] } # 0: PAYGO 1: BYOL
variable product	{ default = ["f5-big-ip-best","f5-big-ip-byol"] } #  0: PAYGO 1: BYOL
variable bigip_version	{ default = ["14.1.404000", "14.1.404000"] } #  0: PAYGO 1: BYOL
variable bigip_license { default = "" }

variable "admin_username" {
    description = "BIG-IP administrative user"
    default     = "admin"
}
## Please check and update the latest DO URL from https://github.com/F5Networks/f5-declarative-onboarding/releases
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable DO_URL {
    description = "URL to download the BIG-IP Declarative Onboarding module"
    type        = string
    default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.9.0/f5-declarative-onboarding-1.9.0-1.noarch.rpm"
}
## Please check and update the latest AS3 URL from https://github.com/F5Networks/f5-appsvcs-extension/releases/latest 
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable AS3_URL {
    description = "URL to download the BIG-IP Application Service Extension 3 (AS3) module"
    type        = string
    default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.16.0/f5-appsvcs-3.16.0-6.noarch.rpm"
}
## Please check and update the latest TS URL from https://github.com/F5Networks/f5-telemetry-streaming/releases/latest 
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable TS_URL {
    description = "URL to download the BIG-IP Telemetry Streaming Extension (TS) module"
    type        = string
    default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.8.0/f5-telemetry-1.8.0-1.noarch.rpm"
}
variable "libs_dir" {
    description = "Directory on the BIG-IP to download the A&O Toolchain into"
    type        = string
    default     = "/config/cloud/aws/node_modules"
}

variable onboard_log {
    description = "Directory on the BIG-IP to store the cloud-init logs"
    type        = string
    default     = "/var/log/startup-script.log"
}