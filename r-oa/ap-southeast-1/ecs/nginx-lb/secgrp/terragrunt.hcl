terraform {
    source = "git@github.com:Incandescere/iac-modules.git//secgrp"
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

    inbound_rules = [
        ["tcp", "0.0.0.0/0", "0", "65535"],
    ]

    outbound_rules = [
        ["tcp", "0.0.0.0/0", "0", "65535"],
    ]
}
