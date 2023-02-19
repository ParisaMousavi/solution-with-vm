module "name" {
  source           = "github.com/ParisaMousavi/aws-naming"
  prefix           = var.prefix
  name             = var.name
  environment      = var.environment
  region_shortname = var.region_shortname
}

# resource "aws_key_pair" "this" {
#   public_key = file("~/.ssh/id_rsa.pub")
# }

module "vm" {
  source             = "github.com/ParisaMousavi/aws-ec2"
  subnet_id          = data.terraform_remote_state.network.outputs.network.public_subnet_ids["ec2s"]
  instance_type      = "t2.micro"
  security_group_ids = ["${module.sg.id["ingress-all"]}"]
  # key_name           = aws_key_pair.this.id
  additional_tags = {
    Name = module.name.ec2_name
  }
}

module "sg" {
  source = "github.com/ParisaMousavi/aws-securitygroup"
  vpc_id = data.terraform_remote_state.network.outputs.network.vpc_id
  rules = {
    "ingress-all" = {
      name = "ingress-all"
      egress = {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 22
        protocol    = "tcp"
        to_port     = 22
      }
      ingress = {
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        protocol    = "-1"
        to_port     = 0
      }
    }
  }
  additional_tags = {
    Name = "ingress-all"
  }
}

output "kjej" {
  value = module.sg.id["ingress-all"]
}
