terraform {}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite"
    contents = <<EOF
provider "azurerm" {
    features{}
}
EOF
}

inputs = {
    privatekeyfile    = "~/.ssh/id_rsa"
    publickeyfile     = "~/.ssh/id_rsa.pub"
    region            = "westus2"
    azs               = ["1","3"]
    cidr              = "10.0.0.0/16"
    allowed_mgmt_cidr = "67.168.239.254/32"
    environment       = "demo"
    prefix            = "mjmtfdemo"
}