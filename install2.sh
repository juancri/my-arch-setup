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
echo "en_US.UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set root password
echo "Setting root password..."
passwd

# Install boot loader
echo "Installing the boot loader..."
pacman -S grub
if [ -d /sys/firmware/efi ]
then
	echo "Detected EFI system..."
	grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=grub
else
	echo "Detected BIOS system..."
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

