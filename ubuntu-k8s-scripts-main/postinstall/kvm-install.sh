sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils -y
sudo adduser ${USER} libvirt
sudo adduser ${USER} kvm
sudo systemctl enable --now libvirtd -y
sudo apt install virt-manager -y
