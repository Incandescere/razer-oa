terraform{
    source = "git@github.com:Incandescere/iac-modules.git//loggroup"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl"))
    project_name = local.account_vars.locals.project_name
    svc_name = local.service_vars.locals.service_name
}

inputs = {
    project_name = local.project_name
    name = "${local.svc_name}-2"
}
