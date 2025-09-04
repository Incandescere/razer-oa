terraform{
    source = "git@github.com:Incandescere/iac-modules.git//igw"
}

dependency vpc {
    config_path = "../vpc"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    project_name = local.account_vars.locals.project_name
}

inputs = {
    project_name = local.project_name
    name    = "internet"
    vpc_id  = dependency.vpc.outputs.vpc_id
    default_rtb_id = dependency.vpc.outputs.default_rtb_id
}
