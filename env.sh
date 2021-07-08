
# Video card
lspci | grep -i vga | grep -i intel
export VIDEO_IS_INTEL=$?
lspci | grep -i vga | grep -i nvidia
export VIDEO_IS_NVIDIA=$?

# Computer kind
hostnamectl status | grep Chassis | grep laptop
export KIND_IS_LAPTOP=$?
hostnamectl status | grep Chassis | grep desktop
export KIND_IS_DESKTOP=$?

# CPU
cat /proc/cpuinfo |grep GenuineIntel
export CPU_IS_INTEL=$?
cat /proc/cpuinfo |grep AMD
export CPU_IS_AMD=$?

install_optional() {
	while true
	do
		read -p "Do you wish to install $1?" yn
		case $yn in
			[Yy]* ) pikaur $2; break;;
			[Nn]* ) exit;;
			* ) echo "Please answer yes or no.";;
		esac
	done
}

