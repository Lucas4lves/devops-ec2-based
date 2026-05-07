module "ec2_instance" {
  source = "../../templates/ec2"
  instance_name = var.instance_name
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  security_group_ids = var.security_group_ids
  custom_tags = var.custom_tags
  ami_id = var.ami_id
}