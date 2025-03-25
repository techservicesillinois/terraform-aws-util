variable "include_subnet_detail" {
  description = "Return attributes should include map consisting of the `aws_subnet` object for the selected subnets"
  type        = bool
  default     = false
}

variable "include_subnets_by_az" {
  description = "Return attributes should include map, each key of which is an availability zone (AZ), with the value stored under each key being a list of corresponding subnets"
  type        = bool
  default     = false
}

variable "subnet_type" {
  description = "Type of subnet to look up (e.g., 'campus', 'private', 'public')"
  default     = null
}

# TODO: The 'tier' variable has been retired; remove in the future.

variable "tier" {
  description = "Deprecated variable; use `subnet_type` instead"
  default     = null

  validation {
    condition     = var.tier == null || var.tier == ""
    error_message = "ERROR: 'tier' argument has been retired; use 'subnet_type' instead."
  }
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
