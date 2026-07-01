locals {
  instances = {
    "devops-ec2-based-0" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type="t2.micro"
      subnet_id="subnet-082a39a091759a832"
      user_data=templatefile("../../templates/scripts/ubuntu/ec2-docker-install.sh", {
    repo_branch = var.repo_branch
  })
    }
      "devops-ec2-based-1" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type="t2.micro"
      subnet_id="subnet-082a39a091759a832"
    }
  }
}

module "ssm_access" {
  source        = "../../templates/ssm/base"
  instance_name = var.instance_name
  vpc_id        = var.vpc_id
}

module "ec2_instance" {
  source               = "../../templates/ec2"
  instances = local.instances
  iam_instance_profile = module.ssm_access.instance_iam_profile
  security_group_ids   = [module.ssm_access.security_group_id]
  custom_tags          = var.custom_tags
}