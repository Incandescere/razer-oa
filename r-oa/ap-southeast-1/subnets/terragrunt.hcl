terraform{
    source = "git@github.com:Incandescere/iac-modules.git//subnet"
}

dependency vpc_id {
    config_path = "../vpc"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

    project_name = local.account_vars.locals.project_name
    subnets_list = local.region_vars.locals.subnets_list
}

inputs = {
    project_name = local.project_name
    vpc_id = dependency.vpc_id.outputs.vpc_id
    subnets_list = local.subnets_list
}
