#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>#
# Route53 Zones
#
resource "aws_route53_zone" "default" {
  name                        = "${var.domain}"
  vpc_id                      = "${aws_vpc.default.id}"

  tags {
    Name                      = "${var.owner}_default_zone"
    Owner                     = "${var.owner}"
  }
}

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>#
# Route53 Records
#
resource "aws_route53_record" "bastion" {
  zone_id                     = "${aws_route53_zone.default.zone_id}"
  name                        = "${var.vdc}-bastion01"
  type                        = "A"
  ttl                         = "300"
  records                     = ["${aws_instance.bastion.private_ip}"]
}

resource "aws_route53_record" "puppetca" {
  zone_id                     = "${aws_route53_zone.default.zone_id}"
  name                        = "${var.vdc}-puppetca01"
  type                        = "A"
  ttl                         = "300"
  records                     = ["${aws_instance.puppetca.private_ip}"]
}

resource "aws_route53_record" "puppetdb" {
  zone_id                     = "${aws_route53_zone.default.zone_id}"
  name                        = "${var.vdc}-puppetdb0${count.index+1}"
  type                        = "A"
  ttl                         = "300"
  count                       = "${length( split( ",", lookup( var.azs, var.region ) ) )}"
  records                     = ["${element(aws_instance.puppetdb.*.private_ip, count.index)}"]
}
