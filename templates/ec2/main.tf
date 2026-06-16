resource "aws_instance" "this" {
  ami = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.custom_tags,{
    Name = var.instance_name,
    ManagedBy = "OpenTofu",
    Module = "Devops EC2 Based"
  })

  iam_instance_profile = var.iam_instance_profile

  vpc_security_group_ids = var.security_group_ids
  subnet_id = var.subnet_id
}