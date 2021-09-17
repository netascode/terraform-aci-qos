variable "preserve_cos" {
  description = "Preserve CoS."
  type        = bool
  default     = false
}

variable "qos_classes" {
  description = "List of QoS classes. Allowed values `level`: 1-6. Default value `admin_state`: true. Allowed values `mtu`: 1-9216. Default value `mtu`: 9000. Allowed values `bandwidth_percent`: 0-100. Default value `bandwidth_percent`: 20. Choices `scheduling`: `wrr`, `strict-priority`. Default value `scheduling`: `wrr`. Choices `congestion_algorithm`: `tail-drop`, `wred`. Default value `congestion_algorithm`: `tail-drop`."
  type = list(object({
    level                = number
    admin_state          = optional(bool)
    mtu                  = optional(number)
    bandwidth_percent    = optional(number)
    scheduling           = optional(string)
    congestion_algorithm = optional(string)
  }))
  default = []

  validation {
    condition = alltrue(
      [for class in var.qos_classes : (class.level >= 1 && class.level <= 6)]
    )
    error_message = "`level`: Minimum value: 1. Maximum value: 6."
  }

  validation {
    condition = alltrue(
      [for class in var.qos_classes : class.mtu == null || (class.mtu >= 1 && class.mtu <= 9216)]
    )
    error_message = "`mtu`: Minimum value: 1. Maximum value: 9216."
  }

  validation {
    condition = alltrue(
      [for class in var.qos_classes : class.bandwidth_percent == null || (class.bandwidth_percent >= 0 && class.bandwidth_percent <= 100)]
    )
    error_message = "`bandwidth_percent`: Minimum value: 0. Maximum value: 100."
  }

  validation {
    condition = alltrue(
      [for class in var.qos_classes : class.scheduling == null || try(contains(["wrr", "strict-priority"], class.scheduling), false)]
    )
    error_message = "`scheduling`: Allowed values are `wrr` or `strict-priority`."
  }

  validation {
    condition = alltrue(
      [for class in var.qos_classes : class.congestion_algorithm == null || try(contains(["tail-drop", "wred"], class.congestion_algorithm), false)]
    )
    error_message = "`congestion_algorithm`: Allowed values are `tail-drop` or `wred`."
  }
}
