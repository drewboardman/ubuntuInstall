#! /bin/bash

# Make sure system up to date
sudo apt-get -y update
sudo apt-get -y upgrade

# I like having this
mkdir -p ~/tmp
mkdir -p ~/bin

# get the files in this repo
sudo apt-get install -y git
cd ~/tmp
git clone https://github.com/drewboardman/ubuntuInstall.git
cd ubuntuInstall

# install packages
/bin/bash packages.sh

# setup user
USER=`whoami`
sudo chsh -s /usr/bin/zsh $USER
sudo usermod -a -G audio,video,netdev $USER

# Add user to transmission group
sudo usermod -a -G debian-transmission $USER

# This disables the need to enter password for sudo'ing
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

# Nautilus acts weird on i3wm
gsettings set org.gnome.desktop.background show-desktop-icons false

# symlink all dotfiles
/bin/bash dotfiles_apply.sh
