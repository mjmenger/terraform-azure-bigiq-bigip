include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = []
}

terraform {
  source = "git::git@github.com:mjmenger/terraform-azure-infrastructure.git"
}