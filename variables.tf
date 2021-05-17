
variable "region" {
    description = "AWS region"
    default = "us-east-1"
}

variable "aws_creds" {
    description = "Access key and Secret key for AWS [Access Keys, Secret Key]"
}

variable "ssh_key_name" {
    description = "name of ssh key to be added to instance"
}

variable "base_name" {
    description = "base name for resources"
    default = "redisuser1-tf"
}

variable "subnet_cidr_block" {
    description = "subnet_cidr_block"
    default = "10.0.0.0/24"
}

variable "subnet_az" {
    description = "subnet availability zone"
    default = "us-east-1a"
}

# ######################################## Memtier Instance Variables

variable "linux_ami" {
    description = "Linux ami to use"
}

variable "instance_type" {
    description = "instance type to use. Default: t3.micro"
    default = "t3.micro"
}

# ########################################  elastic Ips

# variable "rs_eip_1_id" {
#     description = "elastic ip id 1"
# }

# variable "rs_eip_2_id" {
#     description = "elastic ip id 2"
# }

# variable "rs_eip_3_id" {
#     description = "elastic ip id 3"
# }

# ######################################## Redis Enterprise Cluster Variables
# ******************* redis enterpise software instance ami
# you need to search aws marketplace, select the region, and grab ami id.
# https://aws.amazon.com/marketplace/server/configuration?productId=412acaa0-2074-4156-93a4-576366bbf396&ref_=psb_cfg_continue
variable "rs_instance_ami" {
    description = "rs instance ami"
    default     = "ami-0d894ea5521c64557"
}

variable "rs_instance_type" {
    description = "rs instance type"
    default     = "t2.xlarge"
}

# ######################################## DNS

variable "dns_hosted_zone_id" {
    description = "DNS hosted zone Id"
}


# ########################################  cluster commands

variable "re_cluster_username" {
    description = "redis enterprise cluster username"
    default     = "demo@redislabs.com"
}

variable "re_cluster_password" {
    description = "redis enterprise cluster password"
    default     = "123456"
}

# ########################################  memtier commands

variable "memtier_data_input_1" {
  description = "memtier data input (1st)"
  default = "memtier_benchmark -x 3 -n 180000 -c 1 -t 1 --ratio=1:0 --data-size=80 --key-maximum=180000 --pipeline=1000 --key-pattern=S:S --hide-histogram"
}

variable "memtier_benchmark_1" {
  description = "memtier benchmark code to run (1st)"
  default = "memtier_benchmark -x 2 -t 8 -c 100 -n 100 --ratio=1:10000 --data-size=80 --key-maximum=180000 --hide-histogram"
}

variable "outfile_name_1" {
    description = "outfile json name (1st run)"
    default = "mybenchmarkOutfile.json"
}

# ########################################  cluster db commands

variable "redis_db_name_1" {
    description = "redis enterprise db "
    default     = "myDB"
}

variable "redis_db_memory_size_1" {
    description = "redis enterprise db "
    default     = 100000000
}

variable "redis_db_replication_1" {
    description = "redis enterprise db "
    default     = "true"
}

variable "redis_db_sharding_1" {
    description = "redis enterprise db "
    default     = "false"
}

variable "redis_db_shard_count_1" {
    description = "redis enterprise db "
    default     = 1
}

variable "redis_db_proxy_policy_1" {
    description = "redis enterprise db "
    default     = "single"
}

variable "redis_db_shards_placement_1" {
    description = "redis enterprise db "
    default     = "dense"
}

variable "redis_db_data_persistence_1" {
    description = "redis enterprise db "
    default     = "aof"
}

variable "redis_db_aof_policy_1" {
    description = "redis enterprise db "
    default     = "appendfsync-always"
}

variable "redis_db_port" {
    description = "redis enterprise db "
    default     = 10000
}