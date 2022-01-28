resource "aci_rest_managed" "qosInstPol" {
  dn         = "uni/infra/qosinst-default"
  class_name = "qosInstPol"
  content = {
    ctrl = var.preserve_cos == true ? "dot1p-preserve" : ""
  }
}

resource "aci_rest_managed" "qosClass" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "uni/infra/qosinst-default/class-level${each.value.level}"
  class_name = "qosClass"
  content = {
    prio  = "level${each.value.level}"
    admin = each.value.admin_state == false ? "disabled" : "enabled"
    mtu   = each.value.mtu != null ? each.value.mtu : 9216
  }
}

resource "aci_rest_managed" "qosSched" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "${aci_rest_managed.qosClass[each.value.level].dn}/sched"
  class_name = "qosSched"
  content = {
    bw   = each.value.bandwidth_percent != null ? each.value.bandwidth_percent : "20"
    meth = each.value.scheduling != null ? (each.value.scheduling == "strict-priority" ? "sp" : "wrr") : "wrr"
  }
}

resource "aci_rest_managed" "qosQueue" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "${aci_rest_managed.qosClass[each.value.level].dn}/queue"
  class_name = "qosQueue"
  content = {
    limit = "1522"
    meth  = "dynamic"
  }
}

resource "aci_rest_managed" "qosPfcPol" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "${aci_rest_managed.qosClass[each.value.level].dn}/pfcpol-default"
  class_name = "qosPfcPol"
  content = {
    name        = "default"
    adminSt     = "no"
    noDropCos   = ""
    enableScope = "tor"
  }
}

resource "aci_rest_managed" "qosCong" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "${aci_rest_managed.qosClass[each.value.level].dn}/cong"
  class_name = "qosCong"
  content = {
    afdQueueLength   = "0"
    algo             = each.value.congestion_algorithm != null ? each.value.congestion_algorithm : "tail-drop"
    ecn              = "disabled"
    forwardNonEcn    = "disabled"
    wredMaxThreshold = "100"
    wredMinThreshold = "0"
    wredProbability  = "0"
    wredWeight       = "0"
  }
}

resource "aci_rest_managed" "qosBuffer" {
  for_each   = { for class in var.qos_classes : class.level => class }
  dn         = "${aci_rest_managed.qosClass[each.value.level].dn}/buffer"
  class_name = "qosBuffer"
  content = {
    min = "0"
  }
}
