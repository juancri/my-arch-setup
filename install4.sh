
# Install pikaur
echo "Installing pikaur..."
mkdir -p ~/src
cd ~/src
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -si

# Install AUR packages
pikaur -S \
    davinci-resolve-beta \
    google-chrome \
    polybar \
    reaper-bin \
    visual-studio-code-bin \
    zoom

