variable "subnet_type" {
  description = "Type of subnet to look up (e.g., 'campus', 'private', 'public')"
  # TODO: Remove default once 'tier' is deprecated.
  default = ""
}

variable "tier" {
  description = "Deprecated argument; meaning is identical to `subnet_type` and is superseded by any value there"
  default     = ""

  # TODO: Uncomment validation once 'tier' is deprecated, or remove variable.
  # validation {
  #   condition     = var.tier == ""
  #   error_message = "ERROR: 'tier' argument is deprecated; use 'subnet_type' instead."
  # }
}

variable "vpc" {
  description = "Name of Virtual Private Cloud (VPC) from which to look up the subnet IDs"
}

# NOTE: Definition here must be consistent with that in main module.

variable "_debug" {
  description = "Produce debug output (boolean)"
  type        = bool
  default     = false
}
