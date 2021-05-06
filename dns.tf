###########################################################################
# ******** DNS Record for Redis Cluster

# DNS record set from existing hosted zone
# will need to use existing elastic ip variables as well.



# # Get a Hosted Zone from its name and from this data how to creaet a Record Set

data "aws_route53_zone" "selected" {
  zone_id = var.dns_hosted_zone_id
  private_zone = true
}

resource "aws_route53_record" "A_record_1" {
  zone_id = data.aws_route53_zone.selected.zone_id
  #name    = "www.bamos-tf-node-1.${data.aws_route53_zone.selected.name}"
  #name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "1")
  name    = format("%s-%s-node1.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_1
            ]
}

resource "aws_route53_record" "A_record_2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  #name    = "www.bamos-tf-node-1.${data.aws_route53_zone.selected.name}"
  #name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "2")
  name    = format("%s-%s-node2.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_2
            ]
}

resource "aws_route53_record" "A_record_3" {
  zone_id = data.aws_route53_zone.selected.zone_id
  #name    = "www.bamos-tf-node-1.${data.aws_route53_zone.selected.name}"
  #name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "3")
  name    = format("%s-%s-node3.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  type    = "A"
  ttl     = "300"
  records = [
            var.a_record_3
            ]
}


resource "aws_route53_record" "NS_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  #name    = "www.bamos-tf.${data.aws_route53_zone.selected.name}"
  #name    = format("%s.${data.aws_route53_zone.selected.name}", var.ns_record_name)
  name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
  #name    = format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "NS")
  type    = "NS"
  ttl     = "300"
   records = [
            format("%s-%s-node1.${data.aws_route53_zone.selected.name}", var.base_name, var.region),
            format("%s-%s-node2.${data.aws_route53_zone.selected.name}", var.base_name, var.region),
            format("%s-%s-node3.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
             ]
#   records = [
#             format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "1"),
#             format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "2"),
#             format("%s-%s.${data.aws_route53_zone.selected.name}", var.rs_instance_name_root, "3")
#             ]           
}
###########################################################################



# # create a DNS a record
# resource "dns_a_record_set" "www" {
#   zone = "example.com."
#   name = "www"
#   addresses = [
#     "192.168.0.1",
#     "192.168.0.2",
#     "192.168.0.3",
#   ]
#   ttl = 300
# }

# # create a DNS NS record
# resource "dns_ns_record_set" "www" {
#   zone = "example.com."
#   name = "www"
#   nameservers = [
#     "a.iana-servers.net.",
#     "b.iana-servers.net.",
#   ]
#   ttl = 300
# }