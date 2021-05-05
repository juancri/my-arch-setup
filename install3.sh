
# Enable ILoveCandy
echo "Enabling ILoveCandy..."
echo "ILoveCandy" >> /etc/pacman.conf

# Update system
echo "Updating system..."
pacman -Syuu

# Install packages
echo "Installing packages..."
pacman -S \
	adapta-gtk-theme \
	aws-cli \
	base-devel \
	bind \
	bspwm \
	btrfs-progs \
	caja \
	compton \
	eom \
	deluge \
	deluge-gtk \
	feh \
	ffmpeg \
	firefox \
	flameshot \
	gcolor2 \
	git \
	github-cli \
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
	network-manager-applet \
	nmap \
	noto-fonts-emoji \
	openssh \
	pandoc \
	pavucontrol \
	pinta \
	pkgfile \
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
	wget \
	xfce4-notifyd \
	xorg-server \
	xorg-apps \
	xorg-xinit \
	xterm \
	youtube-dl

# Update pkgfile database
echo "Updating pkgfile database..."
pkgfile -u

# Load environment
source ./env.sh

# Video drivers
# Intel
if test ${IS_INTEL} -eq 0
then
	echo "Installing intel drivers..."
	pacman -S xf86-video-intel
elif test ${IS_NVIDIA} -eq 0
then
	echo "Installing NVIDIA drivers..."
	pacman -S nvidia
else
	echo "Video drivers cannot installed automatically"
	lspci
	read -p "Install the video drivers and press [ENTER]"
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
pacman -Sy

# Enable time synchronization
systemctl enable systemd-timesyncd.service
systemctl start systemd-timesyncd.service

# Enable lightdm
echo "Enabling lightdm..."
systemctl enable lightdm

# Run the rest as a user
echo "Running the rest as ${NEW_USER}..."
cp env.sh /home/${NEW_USER}/
cp install4.sh /home/${NEW_USER}/
cp -R dotfiles /home/${NEW_USER}/
runuser -u "${NEW_USER}" -- /home/${NEW_USER}/install4.sh
