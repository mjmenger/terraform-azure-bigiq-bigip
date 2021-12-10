terraform {
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
      version = "1.12.1"
    }
  }
}

provider "bigip" {
  # Configuration options
}

resource "bigip_do" "do-example" {
    count          = length(var.azs)
    do_json        = file("do.json")
    timeout        = 15
    bigip_address  = module.bigip[count.index].mgmtPublicIP
    bigip_user     = module.bigip[count.index].f5_username
    bigip_port     = "443"
    bigip_password = module.bigip[count.index].bigip_password
}

output bigips {
    value = module.bigip[*]
}
