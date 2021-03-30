variable "aws_region" {}

variable "aws_azs" {}
variable "az_count" {}

variable "vpc_cidr_base" {}

variable "eks_nodes" {
  type = object({
    desired_capacity    = string
    max_capacity = string
    min_capaicty = string
    instance_type = string
  })
  sensitive = true
}