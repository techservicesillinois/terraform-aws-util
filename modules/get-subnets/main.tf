locals {
  need_subnet_detail = (var.include_subnet_detail || var.include_subnets_by_az)
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
  tags = var.subnet_type != null ? { SubnetType = var.subnet_type } : null
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
