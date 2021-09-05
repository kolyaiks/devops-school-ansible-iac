data "aws_ami" "latest_amazon_linux_2" {
  owners = [
    "137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_centos7" {
  owners = [
    "679593333241"]
  most_recent = true
  filter {
    name = "name"
    values = [
      "CentOS 7.8 Enterprise CHI/Linux - SL1-*"]
  }
}

data "aws_ami" "latest_ubuntu" {
  owners = [
    "099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04*"]
  }
}

