data "aws_vpc" "project_vpc" {
  filter {
    name = "tag:Name"
    values = var.vpc_name
  }
}

locals {

  project_handler = var.project_handler
  instances = {
    "${var.project_handler}-app-server" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type=var.instance_type
      subnet_id=var.subnet_id
      security_group_ids = [module.security_groups.security_group_ids["${var.project_handler}"]]
      user_data=templatefile("../../templates/scripts/ubuntu/ec2-docker-install.sh", {
    repo_branch = var.repo_branch
  })
    }
      "${var.project_handler}-client-server" = {
      ami_id="ami-0f8a61b66d1accaee"
      instance_type=var.instance_type
      subnet_id=var.subnet_id
      security_group_ids = [module.security_groups.security_group_ids["${var.project_handler}"]]
    }
  }

  security_groups_config={
    "${var.project_handler}" = {
      ingress_rules = [
        {
          from_port = 80
          to_port = 80
          protocol = "tcp"
          cidr_blocks = var.sg_allowed_cidr_blocks
        },
        {
          from_port = 443
          to_port = 443
          protocol = "tcp"
          cidr_blocks = var.sg_allowed_cidr_blocks
        },
        {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          self = true
        }
      ]
      egress_rules = [
        {
          from_port = 0
          to_port = 0
          protocol = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          self = true
        }
      ]
      }
    }
}
module "security_groups" {
  source = "../../templates/networking/sg"
  security_groups_config = local.security_groups_config
  vpc_id = data.aws_vpc.project_vpc.id
}

module "ssm_access" {
  source        = "../../templates/ssm/base"
  instance_name = "${var.project_handler}-${var.instance_name}"
  vpc_name = var.vpc_name
}

module "ec2_instance" {
  source               = "../../templates/ec2"
  instances = local.instances
  iam_instance_profile = module.ssm_access.instance_iam_profile
  security_group_ids   = [module.security_groups.security_group_ids["${var.project_handler}"]]
  custom_tags          = var.custom_tags
}