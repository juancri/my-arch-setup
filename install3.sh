
# Update system
echo "Updating system..."
pacman -Syuu

# Install packages
echo "Installing packages..."
pacman -S \
    aws-cli \
    base-devel \
    bind \
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
    noto-fonts-emoji \
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
    ttf-joypixels \
    virtualbox \
    virtualbox-host-dkms \
    xfce4-notifyd \
    xorg-server \
    xorg-apps \
    xorg-xinit \
    xterm \
    youtube-dl

# Update pkgfile database
echo "Updating pkgfile database..."
pkgfile -u

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
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf

# Enable lightdm
echo "Enabling lightdm..."
systemctl enable lightdm

# Run the rest as a user
echo "Running the rest as ${NEW_USER}..."
cp install4.sh /home/${NEW_USER}/
runuser -u "${NEW_USER}" -- /home/${NEW_USER}/install4.sh

