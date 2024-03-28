terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

provider "linode" {
token = var("LINODE_TOKEN")
}

variable "regions" {
  type    = list(string)
  default = ["us-east", "us-west", "eu-west"]
}

variable "instance_type" {
  type    = string
  default = "g6-standard-1"
}

variable "image" {
  type    = string
  default = "linode/ubuntu20.04"
}

variable "ssh_keys" {
  type = list(string)
  default = [""]
}

resource "linode_instance" "vm" {
  count        = length(var.regions)
  region       = var.regions[count.index]
  type         = var.instance_type
  image        = var.image
  authorized_keys = var.ssh_keys
  label        = "terraform-vm-${element(var.regions, count.index)}"
  
}

output "ip_address" {
  value = [for vm in linode_instance.vm : "${vm.ipv4}"]
}

