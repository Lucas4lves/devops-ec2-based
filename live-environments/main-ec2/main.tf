module "ssm_access" {
  source        = "../../templates/ssm/base"
  instance_name = var.instance_name
  vpc_id        = var.vpc_id
}

module "ec2_instance" {
  source               = "../../templates/ec2"
  instance_name        = var.instance_name
  instance_type        = var.instance_type
  iam_instance_profile = module.ssm_access.instance_iam_profile
  subnet_id            = var.subnet_id
  security_group_ids   = [module.ssm_access.security_group_id]
  custom_tags          = var.custom_tags
  ami_id               = var.ami_id
}