terraform{
    # source = "C:/Users/bryan/Desktop/dev/iac-modules/svc-conn-namespace"
    source = "git@github.com:Incandescere/iac-modules.git//svc-conn-namespace"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    project_name = local.account_vars.locals.project_name
}

inputs = {
    name = local.project_name
}
