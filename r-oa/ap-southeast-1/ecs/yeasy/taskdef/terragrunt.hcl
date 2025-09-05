terraform{
    # source = "C:/Users/bryan/Desktop/dev/iac-modules/ecs-taskdef"
    source = "git@github.com:Incandescere/iac-modules.git//ecs-taskdef"
}

include "root" {
    path = find_in_parent_folders()
}

dependency exerole {
    config_path = "../../iam"
}

dependency taskrole {
    config_path = "../../iam"
}

dependency loggroup {
    config_path = "../loggroup"
}

dependency s3bucket {
    config_path = "../../../s3-pri-con-reg"
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl"))
    project_name = local.account_vars.locals.project_name
    svc_name     = local.service_vars.locals.service_name
}

inputs = {
    project_name       = local.project_name
    name               = local.svc_name
    execution_role_arn = dependency.exerole.outputs.arn
    task_role_arn      = dependency.taskrole.outputs.arn
    cpu                = 256
    memory             = 512
    td_template        = "td-template.tpl"
    os_family          = "LINUX"
    cpu_architecture   = "X86_64"

    #=========================================================
    # populating the tpl file
    containerName = local.svc_name
    portName      = local.svc_name
    image         = "18.136.186.178:5000/yeasy/simple-web"
    loggroup      = dependency.loggroup.outputs.id
    containerPort = 80
}
