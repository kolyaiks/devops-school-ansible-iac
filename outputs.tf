output "control_node_public_ips" {
  value = {
  for key, value in aws_instance.control_node:
  key => value.public_ip
  }
}

output "control_node_private_ips" {
  value = {
  for key, value in aws_instance.control_node:
  key => value.private_ip
  }
}

output "managed_nodes_public_ips" {
  value = {
  for key, value in aws_instance.managed_nodes:
  key => value.public_ip
  }
}

output "managed_nodes_private_ips" {
  value = {
  for key, value in aws_instance.managed_nodes:
  key => value.private_ip
  }
}

//output "ubuntu_private_ip" {
//  value = {
//    "ubuntu_private_ip" : aws_instance.ubuntu.private_ip
//  }
//}
//
//output "ubuntu_public_ip" {
//  value = {
//    "ubuntu_public_ip" : aws_instance.ubuntu.public_ip
//  }
//}