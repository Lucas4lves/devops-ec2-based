module "base-networking" {
  source = "../../templates/networking"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  azs = var.azs
  public_subnets_cidr = var.public_subnets_cidr
}