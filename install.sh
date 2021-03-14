#!/bin/bash

# Setup internet connection
echo "Testing internet connection..."
while true
do
	ping -c 4 google.com && break
	read -p "Setup your internet connection with wifi-menu or a cable and press [ENTER]..."
done

# Sync time
echo "Syncing time..."
timedatectl set-ntp true

# Partition
while true
do
	lsblk
	read -p "Create your partitions and press [ENTER]..."
	read -p "Enter your main partition (eg: sda1): " MAIN_PARTITION
	read -p "Enter your swap partition (eg: sda2 or empty): " SWAP_PARTITION
	echo "Checking partitions..."
	ls "/dev/${MAIN_PARTITION}" \
	  && ls "/dev/${SWAP_PARTITION}" \
	  && read -p "Are you sure you want to delete everything in ${MAIN_PARTITION} and ${SWAP_PARTITION}? [yes/no]" CONFIRM \
	  && [ $CONFIRM = "yes" ] \
	  && break
done

# Create partitions
echo "Creating main partition in /dev/${MAIN_PARTITION}..."
mkfs.btrfs /dev/${MAIN_PARTITION}
echo "Creating swap partition in /dev/${SWAP_PARTITION}..."
mkswap /dev/${SWAP_PARTITION}

# Mount partitions
echo "Mounting partitions..."
mount /dev/${MAIN_PARTITION} /mnt
swapon /dev/${SWAP_PARTITION}

# Install base system
echo "Installing base system..."
pacstrap /mnt base linux linux-firmware

# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

# Copy install script
echo "Copying install script..."
cp ./install2.sh /mnt/root/install2.sh

# Chroot
echo "Chrooting into /mnt..."
arch-chroot /mnt /bin/bash /root/install2.sh

