# get-subnets

Retrieve the IDs of the subnet(s) matching the specified `subnet_type`.

The subnet type can be generated using the modules that make a part of the [techservicesillinois/aws-enterprise-vpc](https://github.com/techservicesillinois/aws-enterprise-vpc) repo on GitHub, which is supported by the networking team at Technology Services at the University of Illinois at Urbana-Champaign.

Three discrete subnet types, campus-facing, private-facing, and public-facing subnets
are described in depth in the [Amazon Web Services, VPC Guide for Illinois](https://answers.uillinois.edu/illinois/page.php?id=71015), and this is the context in which the `get-subnets` submodule was designed. Accordingly, the native users of the `get-subnets` submodule use tag values of `campus`, `private`, and `public`.

However, this submodule supports any alternate scheme with the following conditions:

* An appropriate `SubnetType` tags must be applied to each `aws_subnet` Terraform resource in the target virtual private cloud (VPC).
* Any code invoking this submodule to look up subnets must reference the `SubnetType` tag values used in the alternate scheme.

Example Usage
-----------------

```hcl
  module "public-subnets" {
    source = "git@github.com:techservicesillinois/terraform-aws-util//modules/get-subnets"
  
    subnet_type = "public"
    vpc         = "my-vpc"
  }
```

Argument Reference
-----------------

The following arguments are supported:

* `subnet_type` - (Optional) Type of subnet to look up (e.g., "campus", "private", "public"). This requires the networking to be built with a corresponding `SubnetType` tag (note capitalization).

* `tier` - (Optional) Has same meaning as `subnet_type`, but using this name is Deprecated. This argument remains to support legacy service deployments until they have been migrated to use `subnet_type`. **NOTE: This argument is deprecated in favor of `subnet_type`.**

* `vpc` - (Required) Name of Virtual Private Cloud (VPC) from which the subnet IDs are to be looked up.

Attributes Reference
--------------------

The following attributes are exported:

* `subnets` – object describing subnet(s) matching the specified `subnet_type` on the virtual private cloud (VPC) specified by the `vpc` argument. In the absence of a `subnet_type` argument, list of all subnets for the VPC specified by the `vpc` argument.
**NOTE:** If neither `subnet_type` nor `tier` matches tags on any subnet, the module returns an empty list.
* `vpc` – object for the virtual private cloud (VPC) specified by the `vpc` argument.
