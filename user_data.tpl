#!/bin/bash

echo ${hostname} > /etc/hostname

yum install epel-release -y
yum update -y
yum install mc -y

yum install -y yum-utils -y
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
systemctl enable docker

yum -y install git gcc gcc-c++ ansible nodejs gettext device-mapper-persistent-data lvm2 bzip2 python3-pip python-docker wget nano
yum install docker-compose -y

cd /home/centos && git clone -b 17.1.0 https://github.com/ansible/awx.git

sed -i.back 's/.*admin_password.*/admin_password=password/' /home/centos/awx/installer/inventory
sed -i.back 's/.*secret_key.*/secret_key=key/' /home/centos/awx/installer/inventory
sed -i.back 's/.*pg_database.*/pg_database=postgres/' /home/centos/awx/installer/inventory
sed -i.back 's/.*pg_password.*/pg_password=password/' /home/centos/awx/installer/inventory
sed -i.back 's/.*awx_alternate_dns_servers.*/awx_alternate_dns_servers="8.8.8.8,8.8.4.4"/' /home/centos/awx/installer/inventory
sed -i.back 's/.*postgres_data_dir.*/postgres_data_dir="\/var\/lib\/awx\/pgdocker"/' /home/centos/awx/installer/inventory
sed -i.back 's/.*docker_compose_dir.*/docker_compose_dir="\/var\/lib\/awx\/awxcompose"/' /home/centos/awx/installer/inventory
sed -i.back 's/.*project_data_dir.*/project_data_dir="\/var\/lib\/awx\/projects"/' /home/centos/awx/installer/inventory

ansible-playbook -i /home/centos/awx/installer/inventory /home/centos/awx/installer/install.yml -v

shutdown -r now