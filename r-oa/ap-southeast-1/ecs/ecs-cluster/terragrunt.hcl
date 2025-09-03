terraform{
    # source = "../../../modules/ecs-cluster"
    source = "C:/Users/bryan/Desktop/dev/iac-modules/ecs-cluster"
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
    cluster_name = ""
}