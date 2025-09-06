terraform{
    # source = "git@github.com:Incandescere/iac-modules.git//target-group"
    source = "C:/Users/bryan/Desktop/dev/iac-modules/target-group"
}

dependency vpc {
    config_path = "../../../vpc"
}

include "root" {
    path = find_in_parent_folders()
}

locals {
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl"))
    project_name = local.account_vars.locals.project_name
    service_name = local.service_vars.locals.service_name
    
}

inputs = {
    project_name = local.project_name
    name        = local.service_name
    vpc_id      = dependency.vpc.outputs.vpc_id
    tg_protocol = "HTTP"
    tg_port     = 8080
    ip_addrs    = []

    health_check_path = "/nginx/lb/health"
}