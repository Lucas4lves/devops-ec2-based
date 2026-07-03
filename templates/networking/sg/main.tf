resource "aws_security_group" "this" {
  for_each = var.security_groups_config
  vpc_id = var.vpc_id
  name = "${each.key}-sg"
  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      self = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      self = egress.value.self     
    }
  }
}