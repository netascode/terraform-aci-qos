terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  preserve_cos = true
}

data "aci_rest" "qosInstPol" {
  dn = "uni/infra/qosinst-default"

  depends_on = [module.main]
}

resource "test_assertions" "qosInstPol" {
  component = "qosInstPol"

  equal "ctrl" {
    description = "ctrl"
    got         = data.aci_rest.qosInstPol.content.ctrl
    want        = "dot1p-preserve"
  }
}
