<!-- BEGIN_TF_DOCS -->
# QoS Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

```hcl
module "aci_qos" {
  source  = "netascode/qos/aci"
  version = ">= 0.0.1"

  preserve_cos = "true"
  qos_classes = [{
    level                = 1
    admin_state          = false
    mtu                  = 9000
    bandwidth_percent    = 30
    scheduling           = "strict-priority"
    congestion_algorithm = "wred"
  }]
}

```
<!-- END_TF_DOCS -->