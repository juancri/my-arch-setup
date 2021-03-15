#!/bin/bash

# Set timezone
echo "Setting your timezone..."
while true
do
	read -p "Enter your timezone: " TIMEZONE
	TIMEZONE_FILE="/usr/share/zoneinfo/${TIMEZONE}"
	[ -f "${TIMEZONE_FILE}" ] && break;
done
ln -sf "${TIMEZONE_FILE}" /etc/localtime

# Sync hardware clock
echo "Syncing hardware clock..."
hwclock --systohc

# Set locales
echo "Setting locales..."
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set root password
echo "Setting root password..."
passwd

# Install boot loader
echo "Installing the boot loader..."
if [ -d /sys/firmware/efi ]
then
	echo "Detected EFI system..."
	pacman -S grub efibootmgr
	lsblk
	read -p "Select your efi partition: " EFI_PARTITION
	echo "Mounting EFI partition..."
	mkdir -p /boot/efi
	mount "/dev/${EFI_PARTITION}" /boot/efi
	grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
else
	echo "Detected BIOS system..."
	pacman -S grub
	while true
	do
		read -p "Enter your disk device (eg: sda): " DISK_DEV
		[ -b "/dev/${DISK_DEV}" ] && break
		echo "Cannot find /dev/${DISK_DEV}"
	done
	grub-install --target=i386-pc --debug "/dev/${DISK_DEV}"
fi
echo "Generating grub config..."
grub-mkconfig -o /boot/grub/grub.cfg

# Install network manager and tools
echo "Installing network manager..."
pacman -S \
    networkmanager

# Enable network manager
echo "Enabling network manager..."
systemctl enable NetworkManager

echo "Done! Ready for reboot."
echo "After reboot, run ./install3.sh"

