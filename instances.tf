# ********   Memtier Instance

# import user data
data "template_file" "user_data" {
  template = file("${path.module}/install_memtier_benchmark.yml")
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
    Name = var.memtier_instance_name
  }
}


# *********** Redis Enterprise Cluster Instances

resource "aws_instance" "rs_cluster_instance_1" {
  ami                         = var.rs_instance_ami
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.re_subnet.id
  instance_type               = var.rs_instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [ aws_security_group.re_sg.id ]
  #user_data                   = data.template_file.user_data.rendered

  tags = {
    #Name = format("%s-%s", var.rs_instance_name_root, "1")
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
  #user_data                   = data.template_file.user_data.rendered

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
  #user_data                   = data.template_file.user_data.rendered

  tags = {
    Name = format("%s-%s-node3", var.base_name, var.region)
  }
}

# ****************************     Elastic IP association

resource "aws_eip_association" "rs-eip-assoc-1" {
  instance_id   = aws_instance.rs_cluster_instance_1.id
  allocation_id = var.rs_eip_1_id
  depends_on    = [aws_instance.rs_cluster_instance_1]
}

resource "aws_eip_association" "rs-eip-assoc-2" {
  instance_id   = aws_instance.rs_cluster_instance_2.id
  allocation_id = var.rs_eip_2_id
  depends_on    = [aws_instance.rs_cluster_instance_2]
}

resource "aws_eip_association" "rs-eip-assoc-3" {
  instance_id   = aws_instance.rs_cluster_instance_3.id
  allocation_id = var.rs_eip_3_id
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