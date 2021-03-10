# compute-s3-prefix

Generates an S3 prefix from the input string. The input is usually a
fully-qualified domain name (FQDN). The module generates a hash used
to optimize S3 performance by randomizing physical storage location.

Example Usage
-----------------

```hcl
module "s3-prefix" {
  source = "git@github.com:techservicesillinois/terraform-aws-util//compute-s3-prefix"

  fqdn   = "foobar.test.techservices.illinois.edu"
}
```

Argument Reference
-----------------

The following arguments are supported:

* `fqdn` - (Required) Hostname (or other arbitrary string) to be hashed to form an S3 prefix.
* `prefix_length` – (Optional) Length in bytes of generated prefix (Default: 4).

Attributes Reference
--------------------

The following attributes are exported:

* `hash` – leading four characters of the MD5 hash of the string specified for the `fqdn`.
* `prefix" – S3 prefix consisting of hash prepended to the `fqdn` string.
