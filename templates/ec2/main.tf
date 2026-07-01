resource "aws_instance" "this" {
  for_each = var.instances
  ami = each.value.ami_id
  instance_type = each.value.instance_type

  tags = merge(var.custom_tags,{
    Name = each.key,
    ManagedBy = "OpenTofu",
    Module = "Devops EC2 Based"
  })

  iam_instance_profile = var.iam_instance_profile

  vpc_security_group_ids = var.security_group_ids
  subnet_id              = each.value.subnet_id
  associate_public_ip_address = true

  user_data = each.value.user_data
}