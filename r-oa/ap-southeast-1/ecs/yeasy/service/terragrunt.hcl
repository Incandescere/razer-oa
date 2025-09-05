terraform{
    source = "C:/Users/bryan/Desktop/dev/iac-modules/ecs-service"
    # source = "git@github.com:Incandescere/iac-modules.git//ecs-service"
}

include "root" {
    path = find_in_parent_folders()
}

dependency cluster_id {
    config_path = "../../ecs-cluster"
}

dependency taskdef {
    config_path = "../taskdef"
}

dependency service_connect {
    config_path = "../../svc-conn"
}

dependency subnet_ids {
    config_path = "../../../subnets"
}

dependency secgrp {
    config_path = "../secgrp"
}

dependency tg_arn {
    config_path = "../targetgrp"
}

locals {
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    service_vars = read_terragrunt_config(find_in_parent_folders("service.hcl"))
    project_name = local.account_vars.locals.project_name
    svc_name = local.service_vars.locals.service_name
}

inputs = {
    project_name        = local.project_name
    name                = local.svc_name

    cluster_id          = dependency.cluster_id.outputs.id
    task_definition_arn = dependency.taskdef.outputs.arn
    desired_count       = 1

    container_port      = 80

    //Networking
    public_cluster      = true
    subnets_list        = [
        dependency.subnet_ids.outputs.subnet_ids[0],
        dependency.subnet_ids.outputs.subnet_ids[1]
    ] 
    secgrps_list        = [dependency.secgrp.outputs.sg_id]
    sc_enabled          = true
    svc_conn_namespace  = dependency.service_connect.outputs.arn
    svc_conn_port       = 80
    //only needed if need to associate w alb
    tg_arn_list         = [dependency.tg_arn.outputs.tg_arn]

    //Autoscaling
    clusterName         = "ecs-cluster-r-oa-cluster"
    scalingMetric       = "ECSServiceAverageCPUUtilization"
    scalingTargetValue  = 75
    scaleInCD           = 30
    scaleOutCD          = 30
}
