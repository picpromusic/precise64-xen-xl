#VBOX_VERSION=$(cat /etc/vagabond/vbox_version)
VBOX_VERSION=$1

apt-get -y update
apt-get -y install linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core

mkdir /mnt/iso
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop,ro VBoxGuestAdditions_$VBOX_VERSION.iso /mnt/iso
sh /mnt/iso/VBoxLinuxAdditions.run --nox11
umount /mnt/iso
rm VBoxGuestAdditions_$VBOX_VERSION.iso

apt-get -y install xen-hypervisor-amd64
sed -i 's/GRUB_DEFAULT=.*\+/GRUB_DEFAULT="Ubuntu GNU/Linux, with Xen hypervisor"/' /etc/default/grub
update-grub

sed -i 's/TOOLSTACK=.*\+/TOOLSTACK="xl"/' /etc/default/xen

rm -rf /usr/lib/xorg/modules

apt-get -y remove linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core
apt-get -y purge linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core
apt-get -y autoremove
unset VBOX_VERSION

echo "Don't forgot to reboot"