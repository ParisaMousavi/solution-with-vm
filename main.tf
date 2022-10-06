module "name" {
  source           = "github.com/ParisaMousavi/aws-naming"
  prefix           = var.prefix
  name             = var.name
  environment      = var.environment
  region_shortname = var.region_shortname
}

module "vm" {
  source    = "github.com/ParisaMousavi/aws-ec2"
  subnet_id = data.terraform_remote_state.network.outputs.public_subnet_ids["public_1"]
  additional_tags = {
    Name = module.name.ec2_name
  }
}
