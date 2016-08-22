#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>#
# Provider
#
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>#
# Deployer Key Pair
#
resource "aws_key_pair" "default" {
  key_name = "${var.owner}_puppet"
  public_key = "${var.ssh_key}"
}
