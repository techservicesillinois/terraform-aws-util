variable "prefix_length" {
  description = "Length in bytes of generated prefix (Default: 4)"
  type        = number
  default     = 4
}

variable "fqdn" {
  description = "Fully qualified domain name of the host for which prefix is to be generated"
  type        = string
}
