provider "aws" {
  version = "~> 2.57.0"
  region  = "us-east-1"
}

locals {
  cluster_name = "my-eks-cluster"
}

module "vpc" {
  source = "git::ssh://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"

  aws_region = var.aws_region
  az_count   = var.az_count
  aws_azs    = var.aws_azs

  global_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v12.1.0"
  cluster_name = local.cluster_name
  vpc_id       = module.vpc.aws_vpc_id
  subnets      = module.vpc.aws_subnet_private_prod_ids

  node_groups = {
    eks_nodes = {
      desired_capacity = var.eks_nodes.desired_capacity
      max_capacity     = var.eks_nodes.max_capacity
      min_capaicty     = var.eks_nodes.min_capaicty

      instance_type    = var.eks_nodes.instance_type
    }
  }

  manage_aws_auth = false
}