aws_azs = "us-west-2a, us-west-2b, us-west-2c, us-west-2d"
az_count = 3
vpc_cidr_base = "10.0"

eks_nodes = {
    desired_capacity    = 3
    max_capacity        = 5
    min_capaicty        = 3
    instance_type       = "m4.large"
}

