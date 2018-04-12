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

# install pip2 stuff for ensime
pip2 install sexpdata websocket-client

# setup user
USER=`whoami`
sudo chsh -s /usr/bin/zsh $USER
sudo usermod -a -G audio,video,netdev $USER

# Add user to transmission group
sudo usermod -a -G debian-transmission $USER

# This disables the need to enter password for sudo'ing
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo

# Hansolo
cp hansolo.jpg ~/wallpapers
cp lich.jpg ~/wallpapers

# Install rbenv and newest ruby
rm -fr ~/.rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git \
    ~/.rbenv/plugins/ruby-build
RUBY_VERSION=`rbenv install -l | grep -v - | tail -1`
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

# Nautilus acts weird on i3wm
gsettings set org.gnome.desktop.background show-desktop-icons false

# symlink all dotfiles
/bin/bash dotfiles_apply.sh
