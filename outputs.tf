locals {
    host = aws_instance.memtier.public_ip
    user = "ec2-user"
    program = "/usr/local/bin/memtier_benchmark"
}

output "host" {
    value = local.host
    description = "Public IP for memtier instance"
}

output "user" {
    value = local.user
    description = "user with access to host"
}

output "program" {
    value = local.program
    description = "Absolute path to program on host"
}

output "run_memtier" {
    value = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ${local.user}@${local.host} ${local.program}"
    description = "ssh string to execute memtier_benchmark on target ec2 instance"
}
