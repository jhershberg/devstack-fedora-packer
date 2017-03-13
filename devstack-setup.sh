sudo hostnamectl set-hostname control
sudo dnf update -y vim-minimal
sudo dnf install -y nano python git vim
sudo mkdir /opt/stack
sudo chmod 777 /opt/stack
sudo mkdir -p /opt/logs/stack
sudo chmod 777 /opt/logs/stack
sudo systemctl stop    iptables.service
sudo systemctl disable iptables.service
git clone https://github.com/openstack-dev/devstack.git
cd devstack
git checkout stable/newton
./stack.sh
sudo iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 6080 -j ACCEPT
sed -i -r -e 's/^#*\s*(OFFLINE=).*$/\1True/' local.conf
sed -i -r -e 's/^#*\s*(RECLONE=).*$/\1False/' local.conf

