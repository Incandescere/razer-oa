terraform{
    source = "C:/Users/bryan/Desktop/dev/iac-modules/ecr"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl"))    
    region = local.region_vars.locals.region
    project_name = local.account_vars.locals.project_name
    svc_name = local.service_vars.locals.service_name
}

inputs = {
    project_name = local.project_name
    name = local.svc_name
    region = local.region
}
