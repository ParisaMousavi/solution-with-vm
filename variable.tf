variable "environment" {
  type    = string
  default = "dev"
}

variable "region_shortname" {
  type    = string
  default = "euc1"
}

variable "name" {
  type    = string
  default = "sone"
}

variable "prefix" {
  type    = string
  default = "tone"
}

variable "terraform_remote_state_bucket" {
  type    = string
  default = "tname-myproje-terraform-dev-euc1"
}