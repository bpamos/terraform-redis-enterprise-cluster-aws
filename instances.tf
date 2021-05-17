# ********   Memtier Instance

# import user data
data "template_file" "user_data" {
  template = file("${path.module}/install_memtier_benchmark.yml")


  vars = {
    aws_creds_access_key = var.aws_creds[0]
    aws_creds_secret_key = var.aws_creds[1]
    s3_bucket_name       = format("%s-s3-bucket-%s", var.base_name, random_string.s3_bucket_name.result)
    dns_fdnq             = format("%s-%s.${data.aws_route53_zone.selected.name}", var.base_name, var.region)
    node_1_private_ip    = aws_instance.rs_cluster_instance_1.private_ip
    node_1_external_ip   = aws_eip.rs_cluster_instance_1.public_ip
    node_2_private_ip    = aws_instance.rs_cluster_instance_2.private_ip
    node_2_external_ip   = aws_eip.rs_cluster_instance_2.public_ip
    node_3_private_ip    = aws_instance.rs_cluster_instance_3.private_ip
    node_3_external_ip   = aws_eip.rs_cluster_instance_3.public_ip
    username             = var.re_cluster_username
    password             = var.re_cluster_password
    redis_db_name_1             = var.redis_db_name_1
    redis_db_memory_size_1      = var.redis_db_memory_size_1
    redis_db_replication_1      = var.redis_db_replication_1
    redis_db_sharding_1         = var.redis_db_sharding_1
    redis_db_shard_count_1      = var.redis_db_shard_count_1
    redis_db_proxy_policy_1     = var.redis_db_proxy_policy_1
    redis_db_shards_placement_1 = var.redis_db_shards_placement_1
    redis_db_data_persistence_1 = var.redis_db_data_persistence_1
    redis_db_aof_policy_1       = var.redis_db_aof_policy_1
    redis_db_port               = var.redis_db_port
    memtier_data_input_1        = var.memtier_data_input_1
    memtier_benchmark_1         = var.memtier_benchmark_1
    outfile_name_1              = var.outfile_name_1
  }
}

resource "time_sleep" "wait" {
  depends_on = [aws_instance.rs_cluster_instance_1,aws_instance.rs_cluster_instance_2,aws_instance.rs_cluster_instance_3]

  create_duration = "4m"
}

resource "aws_instance" "memtier" {
  ami                         = var.linux_ami
  subnet_id                   = aws_subnet.re_subnet.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.re_sg.id ]
  user_data                   = data.template_file.user_data.rendered

  tags = {
    Name = format("%s-%s-memtier-node", var.base_name, var.region)
  }

  depends_on = [time_sleep.wait]
}


# *********** Redis Enterprise Cluster Instances

resource "aws_instance" "rs_cluster_instance_1" {
  ami                         = var.rs_instance_ami
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.re_subnet.id
  instance_type               = var.rs_instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.re_sg.id ]

  tags = {
    Name = format("%s-%s-node1", var.base_name, var.region)
  }
}

resource "aws_instance" "rs_cluster_instance_2" {
  ami                         = var.rs_instance_ami
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.re_subnet.id
  instance_type               = var.rs_instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.re_sg.id ]

  tags = {
    Name = format("%s-%s-node2", var.base_name, var.region)
  }
}

resource "aws_instance" "rs_cluster_instance_3" {
  ami                         = var.rs_instance_ami
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.re_subnet.id
  instance_type               = var.rs_instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.re_sg.id ]

  tags = {
    Name = format("%s-%s-node3", var.base_name, var.region)
  }
}

# ****************************     Elastic IP association

resource "aws_eip_association" "rs-eip-assoc-1" {
  instance_id   = aws_instance.rs_cluster_instance_1.id
  allocation_id = aws_eip.rs_cluster_instance_1.id
  depends_on    = [aws_instance.rs_cluster_instance_1]
}

resource "aws_eip_association" "rs-eip-assoc-2" {
  instance_id   = aws_instance.rs_cluster_instance_2.id
  allocation_id = aws_eip.rs_cluster_instance_2.id
  depends_on    = [aws_instance.rs_cluster_instance_2]
}

resource "aws_eip_association" "rs-eip-assoc-3" {
  instance_id   = aws_instance.rs_cluster_instance_3.id
  allocation_id = aws_eip.rs_cluster_instance_3.id
  depends_on    = [aws_instance.rs_cluster_instance_3]
}


### ******************* OLD
## I believe this could be used to create the eips and assocaite them (as opposed to using exisitng eips)
# resource "aws_eip" "re-eip" {
#   vpc   = true
#   count = var.data-node-count
#   tags  = merge({ Name = "${var.vpc-name}-node-eip-${count.index}" }, var.common-tags)
# }

# resource "aws_eip_association" "re-eip-assoc" {
#   count         = var.data-node-count
#   instance_id   = element(aws_instance.re.*.id, count.index)
#   allocation_id = element(aws_eip.re-eip.*.id, count.index)
#   depends_on    = [aws_instance.re, aws_eip.re-eip]
# }