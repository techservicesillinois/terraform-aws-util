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

* `include_subnet_detail` – (Optional) Return attributes should include map consisting of the [`aws_subnet`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) object for the selected subnets. Defaults to `false`.

* `include_subnets_by_az` – (Optional) Return attributes should include map, each key of which is an availability zone (AZ), with the value stored under each key being a list of corresponding subnets. Defaults to `false`.

* `subnet_type` - (Optional) Type of subnet to look up (e.g., "campus", "private", "public"). This requires the networking to be built with a corresponding `SubnetType` tag (note capitalization).

* `vpc` - (Required) Name of Virtual Private Cloud (VPC) from which the subnet IDs are to be looked up.

Attributes Reference
--------------------

The following attributes are exported:

* `subnet_detail` – If `include_subnet_detail` is `true`, this attribute's value is the [`aws_subnet`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) object for the selected subnets. The returned object's keys are the subnet IDs of the selected subnets. If `include_subnet_detail` is `false`, the returned attribute value is `null`.

* `subnets` – object describing subnet(s) matching the specified `subnet_type` on the virtual private cloud (VPC) specified by the `vpc` argument. In the absence of a `subnet_type` argument, list of all subnets for the VPC specified by the `vpc` argument.
**NOTE:** If no subnet has a `SubnetType` tag corresponding to the specified `subnet_type`, an empty list is returned.

* `subnets_by_az` – If `include_subnets_by_az` is `true`, this attribute's value is a map whose keys are the availability zones (AZs) of the selected subnets. The value stored under each key is a list of subnet IDs corresponding to that AZ. If `include_subnets_by_az` is ``false`, this attribute's value is `null`.

* `vpc` – object for the virtual private cloud (VPC) specified by the `vpc` argument.
