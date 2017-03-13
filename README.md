# devstack-fedora-packer

Download a `Fedora-Server-dvd-x86_64-24-*.iso` from https://dl.fedoraproject.org/pub/fedora/linux/releases/24/Server/x86_64/iso/

Change `fedora-qemu.json` to the exact location of where you downloaded your *.iso file to.

Build the VM image like this: `/usr/local/packer build fedora-qemu.json`, it's now in fedora-qemu/fedora24.

Do `sudo dnf install -y virt-manager` to install and `sudo virt-manager` to launch the Virtual Machine Manager UI.  (NB: You must launch it as root with `sudo` because without that you cannot add a network.)

Right-click on the "QEMU/KVM User session" (header!) for "Details" and on the "Virtual Networks" tab click [+] Add; name it e.g. "devstack-packer" and [X] "Enable IPv4 network address space definition", default Network: 192.168.100.0/24 is fine, also keep default [X] "Enable DHCP v4" (192.168.100.128 - 192.168.100.254), but NOT the [ ] "Enable Static Route Definition".  Next Step 4/4 choose (*) "Forwarding to physical network" instead of the default "( ) Isolated virtual network", so default Destination: "Any physical device" and Mode: "NAT".

Now "Create a new virtual machine" using the the Virtual Machine Manager UI (launched as root), and "Import existing disk image" devstack-fedora-packer/fedora-qemu/fedora24 (built above), choosing OS type: "Linux", Version: "Fedora 23" (or 24 if virt-manager has it); Memory 2048 MB, CPUs: 2; Network selection: devstack-packer (created above).

Start this VM, and login to it on the Virt Viewer console as ds / ds.  Do a `ping 8.8.8.8` to make sure it can reach the outside network.  Do a `ifconfig` to see its IP it got from DHCP on the 192.168.100.0/24 network (e.g. 192.168.100.211).  Now e.g. `ssh ds@192.168.100.211` and do `cd devstack; ./stack.sh`

_TODO explain how to ./stack and fix all problems encountered until you have a fully working OpenDaylight dev env ..._

See also http://github.com/vorburger/openstack-devstack-opendaylight-vagrant/ for a similar project.

