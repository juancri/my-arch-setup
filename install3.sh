
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
    ffmpeg \
    firefox \
    gcolor2 \
    git \
    github-cli \
    gnome-screenshot \
    gparted \
    htop \
    httpie \
    imagemagick \
    jq \
    lightdm \
    lightdm-gtk-greeter \
    mc \
    meld \
    mpv \
    neovim \
    pandoc \
    pavucontrol \
    pinta \
    pkgfile \
    plank \
    pulseaudio \
    pulseaudio-alsa \
    speedtest-cli \
    sudo \
    synapse \
    virtualbox \
    virtualbox-host-dkms

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


