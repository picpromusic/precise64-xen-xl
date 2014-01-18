#VBOX_VERSION=$(cat /etc/vagabond/vbox_version)
VBOX_VERSION=$1

apt-get install linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core
mkdir /mnt/iso
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop,ro VBoxGuestAdditions_$VBOX_VERSION.iso /mnt/iso
sh /mnt/iso/VBoxLinuxAdditions.run --nox11
umount /mnt/iso
rm VBoxGuestAdditions_$VBOX_VERSION.iso
apt-get remove linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core
apt-get purge linux-headers-$(uname -r) linux-headers-generic build-essential xserver-xorg xserver-xorg-core
unset VBOX_VERSION

