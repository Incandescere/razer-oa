terraform{
    source = "git@github.com:Incandescere/iac-modules.git//alb-listener-listenerrules"
}

dependency vpc {
    config_path = "../vpc"
}

dependency secgrp {
    config_path = "../alb-secgrp"
}

dependency subnets {
    config_path = "../subnets"
}

dependency registry_tg {
    config_path = "../ecs/pri-con-reg-svc/targetgrp"
}

dependency nginx_tg {
    config_path = "../ecs/nginx-rev-proxy/targetgrp"
}

dependency yeasy_tg {
    config_path = "../ecs/yeasy/targetgrp"
}

dependency yeasy2_tg {
    config_path = "../ecs/yeasy/targetgrp2"
}

dependency nginx_lb_tg {
    config_path = "../ecs/nginx-lb/targetgrp"
}



# dependency lblogs_bucket {
#     config_path = "../lblogs-s3"
# }

include "root" {
    path = find_in_parent_folders()
}

locals {
    region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
    account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
    project_name = local.account_vars.locals.project_name
}

inputs = {
    project_name    = local.project_name
    name            = "pub"
    vpc_id          = dependency.vpc.outputs.vpc_id
    secgrps         = [dependency.secgrp.outputs.sg_id]
    subnets     = [
        dependency.subnets.outputs.subnet_ids[0], 
        dependency.subnets.outputs.subnet_ids[1] 
    ]

    lb_listener_protocol = "HTTP"
    lb_listener_port     = 80
    
    listener_rules = [
        [["/v2*"], dependency.registry_tg.outputs.tg_id],
        [["/nginx/lb*"], dependency.nginx_lb_tg.outputs.tg_id],
        [["/nginx*"], dependency.nginx_tg.outputs.tg_id],
        [["/*"], dependency.yeasy_tg.outputs.tg_id],
        [["/*"], dependency.yeasy2_tg.outputs.tg_id],
    ]

    //leave out to disable logging
    # log_bucket = dependency.lblogs_bucket.outputs.id
}

//temporarily disabled access logging