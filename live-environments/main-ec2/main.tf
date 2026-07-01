locals {
  instances = {
    "devops-ec2-based-0" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type=var.instance_type
      subnet_id=var.subnet_id
      user_data=templatefile("../../templates/scripts/ubuntu/ec2-docker-install.sh", {
    repo_branch = var.repo_branch
  })
    }
      "devops-ec2-based-1" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type=var.instance_type
      subnet_id=var.subnet_id
    }
  }
}

module "ssm_access" {
  source        = "../../templates/ssm/base"
  instance_name = var.instance_name
  vpc_name = var.vpc_name
}

module "ec2_instance" {
  source               = "../../templates/ec2"
  instances = local.instances
  iam_instance_profile = module.ssm_access.instance_iam_profile
  security_group_ids   = [module.ssm_access.security_group_id]
  custom_tags          = var.custom_tags
}