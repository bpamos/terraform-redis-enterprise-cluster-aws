
locals {
    fqdn = format("%s-%s.${aws_route53_zone.redis_hosted_zone.name}", var.base_name, var.region)
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
