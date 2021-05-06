
variable "region" {
    description = "AWS region"
}

variable "aws_creds" {
    description = "Access key and Secret key for AWS [Access Keys, Secret Key]"
}

variable "ssh_key_name" {
    description = "name of ssh key to be added to instance"
}

variable "vpc_name" {
    description = "VPC name"
}

variable "base_name" {
    description = "base name for resources"
}

variable "subnet_cidr_block" {
    description = "subnet_cidr_block"
}

variable "subnet_az" {
    description = "subnet availability zone"
}

# Memtier Instance Variables

variable "linux_ami" {
    description = "Linux ami to use"
}

variable "instance_type" {
    description = "instance type to use. Default: t3.micro"
    default = "t3.micro"
}

variable "memtier_instance_name" {
    description = "memtier instance name"
}

# elastic Ips

variable "rs_eip_1_id" {
    description = "elastic ip id 1"
}

variable "rs_eip_2_id" {
    description = "elastic ip id 2"
}

variable "rs_eip_3_id" {
    description = "elastic ip id 3"
}

# Redis Enterprise Cluster Variables

variable "rs_instance_ami" {
    description = "memtier instance name"
}

variable "rs_instance_type" {
    description = "memtier instance name"
}

# variable "rs_instance_name_root" {
#   description = "The name of the client VM used to run memtier_benchmark"
#   type = string
#   default = "bamos-test-vm"
# }

# ******************************************* DNS

# variable "hosted_zone_name" {
#     description = "DNS hosted zone name"
# }

variable "dns_hosted_zone_id" {
    description = "DNS hosted zone Id"
}

variable "a_record_1" {
    description = "A record 1 Ip Address"
}

variable "a_record_2" {
    description = "A record 2 Ip Address"
}

variable "a_record_3" {
    description = "A record 3 Ip Address"
}

# variable "ns_record_name" {
#     description = "NS record name"
# }

################################################### OLD
# variable "aws_security_group_name" {
#     description = "AWS security group name"
# }

# variable "security_group_id" {
#     description = "Id of the security group applied to the instance"
# }