
resource "aws_eip" "rs_cluster_instance_1" {
  network_border_group = var.region
  vpc      = false

  tags = {
      Name = format("%s-%s-eip1", var.base_name, var.region)
  }

}

resource "aws_eip" "rs_cluster_instance_2" {
  network_border_group = var.region
  vpc      = false

  tags = {
      Name = format("%s-%s-eip2", var.base_name, var.region)
  }

}

resource "aws_eip" "rs_cluster_instance_3" {
  network_border_group = var.region
  vpc      = false

  tags = {
      Name = format("%s-%s-eip3", var.base_name, var.region)
  }

}