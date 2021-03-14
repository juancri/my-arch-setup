
# Install pikaur
echo "Installing pikaur..."
mkdir -p ~/src
cd ~/src
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -si

# Install AUR packages
pikaur -S \
    alttab-git \
    google-chrome \
    polybar \
    reaper-bin \
    visual-studio-code-bin \
    zoom \
    grun

# Install bash git prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Copy dot files
echo "Copying dot files..."
cp ./dotfiles/bashrc ~/.bashrc
mkdir -p ~/.config/bspwm
cp ./dotfiles/bspwmrc ~/.config/bspwm
cp ./dotfiles/polybar ~/.config/bspwm
cp ./dotfiles/sxhkdrc ~/.config/bspwm

# Generate SSH key
echo "Generating SSH key..."
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -N ""

