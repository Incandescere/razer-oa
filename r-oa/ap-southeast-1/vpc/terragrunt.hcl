terraform{
    # source = "../../modules/vpc"
    source = "C:/Users/bryan/Desktop/dev/iac-modules/vpc"
    # source = "git@github.com:Incandescere/iac-modules.git//vpc"
}


include "root" {
    path = find_in_parent_folders()
}

locals {
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    vpc1_cidr = local.region_vars.locals.vpc1_cidr
    project_name = local.account_vars.locals.project_name

}

inputs = {
    project_name = local.project_name
    name           = "mainvpc"
    vpc_cidr_block = local.vpc1_cidr
}