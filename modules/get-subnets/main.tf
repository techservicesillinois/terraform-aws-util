# TODO: Remove local variable and replace local.subnet_type with
# var.subnet_type elsewhere once 'tier' is deprecated.

locals {
  need_subnet_detail = (var.include_subnet_detail || var.include_subnets_by_az)
  subnet_type        = can(coalesce(var.subnet_type, var.tier)) ? coalesce(var.subnet_type, var.tier) : null
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

data "aws_subnet" "selected" {
  for_each = local.need_subnet_detail ? toset(data.aws_subnets.selected.ids) : []

  id = each.value
}

locals {
  subnet_detail = var.include_subnet_detail ? data.aws_subnet.selected : null
  subnets_by_az = var.include_subnets_by_az ? {
    for id, subnet in data.aws_subnet.selected : subnet.availability_zone => id...
  } : null
}
