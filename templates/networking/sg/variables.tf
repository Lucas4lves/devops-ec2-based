variable "security_groups_config" {
  type = map(object({
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      self = optional(bool, false)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      self = optional(bool, false)
    }))
  }))
  default = {}
}

variable "vpc_id" {
  type = string
}