variable "control_node" {
  type = map(string)
  default = {
    "control.example.com" = "t3.large"
  }
}

variable "managed_nodes" {
  type = map(string)
  default = {
    "node1.example.com" = "t3.micro",
    "node2.example.com" = "t3.micro"
  }
}

variable "key_name" {
  type = string
  default = "kolyaiks_iam"
}