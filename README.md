<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-qos/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-qos/actions/workflows/test.yml)

# Terraform ACI QoS Module

Manages ACI QoS

Location in GUI:
`Fabric` » `Access Policies` » `Policies` » `Global` » `QOS Class`

## Examples

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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_preserve_cos"></a> [preserve\_cos](#input\_preserve\_cos) | Preserve CoS. | `bool` | `false` | no |
| <a name="input_qos_classes"></a> [qos\_classes](#input\_qos\_classes) | List of QoS classes. Allowed values `level`: 1-6. Default value `admin_state`: true. Allowed values `mtu`: 1-9216. Default value `mtu`: 9000. Allowed values `bandwidth_percent`: 0-100. Default value `bandwidth_percent`: 20. Choices `scheduling`: `wrr`, `strict-priority`. Default value `scheduling`: `wrr`. Choices `congestion_algorithm`: `tail-drop`, `wred`. Default value `congestion_algorithm`: `tail-drop`. | <pre>list(object({<br>    level                = number<br>    admin_state          = optional(bool)<br>    mtu                  = optional(number)<br>    bandwidth_percent    = optional(number)<br>    scheduling           = optional(string)<br>    congestion_algorithm = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `qosInstPol` object. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.qosBuffer](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosClass](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosCong](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosInstPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosPfcPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosQueue](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.qosSched](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->