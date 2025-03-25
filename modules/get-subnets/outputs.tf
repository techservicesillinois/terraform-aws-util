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

output "_subnet_type" {
  value = (var._debug) ? var.subnet_type : null
}

output "_vpc" {
  value = (var._debug) ? var.vpc : null
}
