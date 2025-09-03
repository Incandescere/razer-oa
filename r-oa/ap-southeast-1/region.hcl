locals {
    region = "ap-southeast-1"
    vpc1_cidr = "100.0.0.0/24"

    subnets_list = [
        ["r-oa-az-a", "100.0.0.0/25", "ap-southeast-1a"],
        ["r-oa-az-b", "100.0.0.128/25", "ap-southeast-1b"],
    ]
}