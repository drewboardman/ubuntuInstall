# clone dotfiles
rm -rf ~/dotfiles
git clone -b laptop https://github.com/drewboardman/dotfiles.git \
  ~/dotfiles

# install oh-my-zsh before you symlink zshrc
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm ~/.zshrc

# Get adobe source code pro
sh ~/dotfiles/fonts.sh

#install dotfiles
sh ~/dotfiles/install.sh

# set up neovim
mkdir ~/.config/nvim
echo "set runtimepath+=~/.vim,~/.vim/after
  set packpath+=~/.vim
  source ~/.vimrc" > ~/.config/nvim/init.vim

# Vim colorscheme
mkdir ~/.vim/colors
cd ~/.vim/colors
wget https://raw.githubusercontent.com/gosukiwi/vim-atom-dark/master/colors/atom-dark-256.vim

# Vim setup (seems to kill the script, so do it last)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
