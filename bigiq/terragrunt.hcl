include "root" {
  path = find_in_parent_folders()
}

dependency "infrastructure" {
  config_path = "../infrastructure"
}

inputs = {
  resourcegroup_location = dependency.infrastructure.outputs.resourcegroup_location
  resourcegroup_name     = dependency.infrastructure.outputs.resourcegroup_name
  private_subnet_ids     = dependency.infrastructure.outputs.private_subnet_ids
  public_subnet_ids      = dependency.infrastructure.outputs.public_subnet_ids
  management_subnet_ids  = dependency.infrastructure.outputs.management_subnet_ids
}