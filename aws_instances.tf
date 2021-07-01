# Resource: aws_instance (provides aws instances)
# Create your aws instances, 
# 1 memtier instance with a template file of variables for commands to run after instance creation.
# 3 Redis Enterprise marketplace instances (with RS installed)


# Memtier Instance - Variable Configuration

# import user data
# template file can pass user data into instance.
# here we provide various variables pulled from created resources and variables.tf 
# to use inside the "install_memtier_bnechmark.yml" file
data "template_file" "user_data" {
  template = file("${path.module}/install_memtier_benchmark.yml")

  # variables used inside yml
  vars = {
    aws_creds_access_key = var.aws_creds[0]
    aws_creds_secret_key = var.aws_creds[1]
    s3_bucket_name       = format("%s-s3-bucket-%s", var.base_name, random_string.s3_bucket_name.result)
    dns_fdnq             = format("%s-%s.${aws_route53_zone.redis_hosted_zone.name}", var.base_name, var.region)
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

# Sleep resource, depends on all redis enterprise instances to be created.
# after an instance is created, it needs to pass all of its checks, a sleep time of 4 minutes should allow this.
# otherwise the memtier instance will run commands and the instances may not be ready to respond
# TODO: do this without time_sleep command
resource "time_sleep" "wait" {
  depends_on = [aws_instance.rs_cluster_instance_1,aws_instance.rs_cluster_instance_2,aws_instance.rs_cluster_instance_3]

  create_duration = "4m"
}

# create aws instance for memtier and rest api commands to create cluster.
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

  depends_on = [time_sleep.wait] # wait for rs instances to be created and checks passed.
}


# Redis Enterprise Cluster Instances

# create Redis Enterprise cluster instance (requires ami)
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

# Elastic IP association

# associate aws eips created in "aws_eip.tf" to each instance
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