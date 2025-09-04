locals {
    region = "ap-southeast-1"
    vpc1_cidr = "100.0.0.0/24"

    subnets_list = [
        ["pub-a", "100.0.0.0/25", "ap-southeast-1a"],
        ["pub-b", "100.0.0.128/25", "ap-southeast-1b"],
    ]
}