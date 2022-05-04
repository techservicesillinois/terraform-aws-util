output "subnets" {
  value = data.aws_subnets.selected
}

output "subnet_detail" {
  value = local.subnet_detail
}

output "subnets_by_az" {
  value = local.subnets_by_az
}

output "vpc" {
  value = data.aws_vpc.selected
}

# Debug-only variables.

# TODO: Remove this variable once 'tier' is deprecated.
output "_coalesced_subnet_type" {
  value = (var._debug) ? local.subnet_type : null
}

output "_subnet_type" {
  value = (var._debug) ? var.subnet_type : null
}

output "_tier" {
  value = (var._debug) ? var.tier : null
}

output "_vpc" {
  value = (var._debug) ? var.vpc : null
}
