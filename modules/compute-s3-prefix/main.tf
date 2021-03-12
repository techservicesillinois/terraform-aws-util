locals {
  # Generate appropriately-sized hash from var.fqdn.
  hash = substr(md5(var.fqdn), 0, var.prefix_length)

  # Generate S3 prefix consisting of hash prepended to var.fqdn itself.
  prefix = format("%s-%s", local.hash, var.fqdn)
}
