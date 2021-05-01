
# Install pikaur
echo "Installing pikaur..."
mkdir -p ~/src
cd ~/src
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -si

# Install AUR packages
pikaur -S \
	google-chrome \
	polybar \
	siji \
	visual-studio-code-bin \
	zoom \
	grun

# Install bash git prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Load environment
source ./env.sh

# Copy dot files
echo "Copying dot files..."
cp ./dotfiles/bashrc ~/.bashrc
mkdir -p ~/.config/bspwm
if test ${IS_LAPTOP} -eq 0
then
	cp ./dotfiles/laptop/bspwmrc ~/.config/bspwm
	cp ./dotfiles/laptop/polybar ~/.config/bspwm
	cp ./dotfiles/laptop/sxhkdrc ~/.config/bspwm
else
	cp ./dotfiles/desktop/bspwmrc ~/.config/bspwm
	cp ./dotfiles/desktop/polybar ~/.config/bspwm
	cp ./dotfiles/desktop/sxhkdrc ~/.config/bspwm
fi

# Generate SSH key
echo "Generating SSH key..."
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -N ""
