
# Update system
echo "Updating system..."
pacman -Syuu

# Install packages
echo "Installing packages..."
pacman -S \
    aws-cli \
    base-devel \
    bspwm \
    deluge \
    deluge-gtk \
    feh \
    ffmpeg \
    firefox \
    gcolor2 \
    git \
    github-cli \
    gnome-keyring \
    gnome-screenshot \
    gparted \
    htop \
    httpie \
    imagemagick \
    jq \
    lightdm \
    lightdm-gtk-greeter \
    man \
    mate-terminal \
    mc \
    meld \
    mpv \
    neovim \
    openssh \
    pandoc \
    pavucontrol \
    pinta \
    pkgfile \
    plank \
    pulseaudio \
    pulseaudio-alsa \
    sxhkd \
    speedtest-cli \
    sudo \
    synapse \
    tldr \
    virtualbox \
    virtualbox-host-dkms \
    xorg-server \
    xorg-apps \
    xorg-xinit \
    xterm \
    youtube-dl

# Video drivers
# Intel
lspci | grep -i vga | grep -i intel
IS_INTEL=$?
if test ${IS_INTEL} -eq 0
then
	echo "Installing intel drivers..."
	pacman -S xf86-video-intel
fi

# Create a user
echo "Creating a new user..."
read -p "Username: " NEW_USER
echo "Creating user: ${NEW_USER}..."
useradd -m "${NEW_USER}"
echo "Setting password for ${NEW_USER}..."
passwd "${NEW_USER}"
echo "Adding user ${NEW_USER} to wheel..."
gpasswd -a "${NEW_USER}" wheel
echo "Setting sudo to nopasswd..."
read -p "Press [ENTER] and uncomment the line: %wheel ALL=(ALL) NOPASSWD: ALL"
EDITOR=nvim visudo

# Enable multilib
echo "Enabling multilib..."
read -p "Pres [ENTER] and uncomment the multilib section"
nvim /etc/pacman.conf
pacman -Syuu

# Enable lightdm
systemctl enable lightdm

