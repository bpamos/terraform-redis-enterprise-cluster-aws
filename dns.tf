###########################################################################
# ******** DNS Record for Redis Cluster

# DNS record set from existing hosted zone
# will need to use existing elastic ip variables as well.



# # Get a Hosted Zone from its name and from this data how to create a Record Set

data "aws_route53_zone" "selected" {
  zone_id = var.dns_hosted_zone_id
  private_zone = true
}

resource "aws_route53_record" "A_record_1" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = format("%s-%s-node1.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_1
            ]
}

resource "aws_route53_record" "A_record_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = format("%s-%s-node2.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_2
            ]
}

resource "aws_route53_record" "A_record_3" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = format("%s-%s-node3.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_3
            ]
}


resource "aws_route53_record" "NS_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "NS"
  ttl     = "300"
   records = [
            format("%s-%s-node1.${data.aws_route53_zone.selected.name}", var.base_name, var.region),
            format("%s-%s-node2.${data.aws_route53_zone.selected.name}", var.base_name, var.region),
            format("%s-%s-node3.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
             ]         
}