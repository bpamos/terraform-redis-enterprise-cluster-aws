# locals {
#     host = aws_instance.memtier.public_ip
#     user = "ec2-user"
#     program = "/usr/local/bin/memtier_benchmark"
# }

# output "host" {
#     value = local.host
#     description = "Public IP for memtier instance"
# }

# output "user" {
#     value = local.user
#     description = "user with access to host"
# }

# output "program" {
#     value = local.program
#     description = "Absolute path to program on host"
# }

# output "run_memtier" {
#     value = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ${local.user}@${local.host} ${local.program}"
#     description = "ssh string to execute memtier_benchmark on target ec2 instance"
# }

# locals {
#     aws_eip = aws_eip.memtier.public_ip
# }

# output "aws_eip_memtier" {
#     value = local.aws_eip
# }
locals {
    fqdn = format("%s-%s.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
}

output "RedisEnterpriseClusterFQDN" {
    value = "https://${local.fqdn}.redisdemo.com:8443/"
}

output "RedisEnterpriseClusterUsername" {
    value = "${var.re_cluster_username}"
}

output "RedisEnterpriseClusterPassword" {
    value = "${var.re_cluster_password}"
}
