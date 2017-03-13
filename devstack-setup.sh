sudo hostnamectl set-hostname control
sudo dnf update -y vim-minimal
sudo dnf install -y python git vim
sudo mkdir /opt/stack
sudo chmod 777 /opt/stack
sudo mkdir -p /opt/logs/stack
sudo chmod 777 /opt/logs/stack
sudo systemctl stop firewalld
sudo systemctl disable firewalld
git clone https://github.com/openstack-dev/devstack.git
