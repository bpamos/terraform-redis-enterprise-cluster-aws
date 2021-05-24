
locals {
    fqdn = format("%s-%s.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
}

output "RedisEnterpriseClusterFQDN" {
    value = "https://${local.fqdn}:8443/"
}

output "RedisEnterpriseClusterUsername" {
    value = "${var.re_cluster_username}"
}

output "RedisEnterpriseClusterPassword" {
    value = "${var.re_cluster_password}"
}
