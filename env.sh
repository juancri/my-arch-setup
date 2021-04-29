
# Video card
lspci | grep -i vga | grep -i intel
export IS_INTEL=$?
lspci | grep -i vga | grep -i nvidia
export IS_NVIDIA=$?

# Computer kind
hostnamectl status | grep Chassis | grep laptop
export IS_LAPTOP=$?
hostnamectl status | grep Chassis | grep desktop
export IS_DESKTOP=$?
