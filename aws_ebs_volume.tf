# AWS EC2 instances are ephemeral, but your presistent database storage should not be.
# For each node in the cluste configure both persistent and ephemeral storage.


# Attach Persistant Volumes
# Instance 1
resource "aws_ebs_volume" "persistant_rs_cluster_instance_1" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-1-persistant", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "persistant_rs_cluster_instance_1" {
  device_name = "/dev/sdj"
  volume_id   = aws_ebs_volume.persistant_rs_cluster_instance_1.id
  instance_id = aws_instance.rs_cluster_instance_1.id
}

# Instance 2
resource "aws_ebs_volume" "persistant_rs_cluster_instance_2" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-2-persistant", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "persistant_rs_cluster_instance_2" {
  device_name = "/dev/sdj"
  volume_id   = aws_ebs_volume.persistant_rs_cluster_instance_2.id
  instance_id = aws_instance.rs_cluster_instance_2.id
}

# Instance 3
resource "aws_ebs_volume" "persistant_rs_cluster_instance_3" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-3-persistant", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "persistant_rs_cluster_instance_3" {
  device_name = "/dev/sdj"
  volume_id   = aws_ebs_volume.persistant_rs_cluster_instance_3.id
  instance_id = aws_instance.rs_cluster_instance_3.id
}

# Attach Ephemeral Volumes
# Instance 1
resource "aws_ebs_volume" "ephemeral_rs_cluster_instance_1" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-1-ephemeral", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "ephemeral_rs_cluster_instance_1" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ephemeral_rs_cluster_instance_1.id
  instance_id = aws_instance.rs_cluster_instance_1.id
}

# Instance 2
resource "aws_ebs_volume" "ephemeral_rs_cluster_instance_2" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-2-ephemeral", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "ephemeral_rs_cluster_instance_2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ephemeral_rs_cluster_instance_2.id
  instance_id = aws_instance.rs_cluster_instance_2.id
}

# Instance 3
resource "aws_ebs_volume" "ephemeral_rs_cluster_instance_3" {
  availability_zone = var.subnet_az
  size              = var.rs-volume-size

  tags = {
    Name = format("%s-%s-ec2-3-ephemeral", var.base_name, var.region)
  }
}

resource "aws_volume_attachment" "ephemeral_rs_cluster_instance_3" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ephemeral_rs_cluster_instance_3.id
  instance_id = aws_instance.rs_cluster_instance_3.id
}


