
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
	grun \
	ntfd-bin \
	polybar \
	siji \
	visual-studio-code-bin \
	zoom

# Install bash git prompt
echo "Installing bash git prompt..."
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Install nodejs
echo "Installing nodejs..."
mkdir -p ~/src/node
cd ~/src/node
wget https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz
tar xvf node-v14.16.1-linux-x64.tar.xz
cd -

# Load environment
source ./env.sh

# Copy dot files
echo "Copying dot files..."
cp ./dotfiles/bashrc ~/.bashrc
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/ntfd
if test ${IS_LAPTOP} -eq 0
then
	cp ./dotfiles/laptop/bspwmrc ~/.config/bspwm
	cp ./dotfiles/laptop/polybar ~/.config/bspwm
	cp ./dotfiles/laptop/sxhkdrc ~/.config/bspwm
	cp ./dotfiles/laptop/ntfd.toml ~/.config/ntfd/config.toml
else
	cp ./dotfiles/desktop/bspwmrc ~/.config/bspwm
	cp ./dotfiles/desktop/polybar ~/.config/bspwm
	cp ./dotfiles/desktop/sxhkdrc ~/.config/bspwm
	cp ./dotfiles/desktop/ntfd.toml ~/.config/ntfd/config.toml
fi

# Generate SSH key
echo "Generating SSH key..."
mkdir -p ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -N ""

# Configure git
echo "Configuring git..."
read -p "Enter your name:" FULLNAME
read -p "Enter your email:" EMAIL
git config --global user.name "${FULLNAME}"
git config --global user.email "${EMAIL}"
