module "aci_qos" {
  source  = "netascode/qos/aci"
  version = ">= 0.2.0"

  preserve_cos = true
  qos_classes = [{
    level                = 1
    admin_state          = false
    mtu                  = 9000
    bandwidth_percent    = 30
    scheduling           = "strict-priority"
    congestion_algorithm = "wred"
  }]
}
