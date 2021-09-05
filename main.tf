resource "aws_instance" "control_node" {
  for_each = (var.control_node)

  ami = data.aws_ami.latest_centos7.id
  instance_type = each.value
  key_name = var.key_name

  user_data = templatefile("user_data.tpl", {
    hostname = each.key
  })

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  root_block_device {
    volume_size = 20
    volume_type = "standard"
  }

  tags = {
    Name = each.key
  }
}

resource "aws_instance" "managed_nodes" {
  for_each = (var.managed_nodes)

  ami = data.aws_ami.latest_centos7.id
  instance_type = each.value
  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id
  ]

  root_block_device {
    volume_size = 10
    volume_type = "standard"
  }

  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  ingress {
    from_port = 21
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  //for passive mode vsftpd
  ingress {
    from_port = 10090
    to_port = 10100
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = true
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}