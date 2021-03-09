locals {
  # Generate four-character hash from var.fqdn.
  hash   = substr(md5(var.fqdn), 0, 4)
  # Generate S3 prefix consisting of hash prepended to var.fqdn itself.
  prefix = format("%s-%s", local.hash, var.fqdn)
}

output "hash" {
  value = local.hash
}

output "prefix" {
  value = local.prefix
}

variable "fqdn" {
  description = "NEED ME"
  type        = string
}
