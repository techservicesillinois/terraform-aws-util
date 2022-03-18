# TODO: Remove local variable and replace local.subnet_type with
# var.subnet_type elsewhere once 'tier' is deprecated.

locals {
  subnet_type = can(coalesce(var.subnet_type, var.tier)) ? coalesce(var.subnet_type, var.tier) : null
}

data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  # SubnetType filter only applies if caller specifies subnet_type argument.
  tags = local.subnet_type != null ? { SubnetType = local.subnet_type } : {}
}
