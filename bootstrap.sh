#!/usr/bin/env bash

git pull origin master;

function doIt() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "bootstrap.sh" \
    --exclude "tmux.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~;
}

# Powerline fonts installation functions

function is_powerline_fonts_exist() {
  if ls ~/Library/Fonts/*Powerline.ttf 1> /dev/null 2>&1; then
    return 0;
  else
    return 1;
  fi
}

function install_powerline_fonts() {
  if is_powerline_fonts_exist; then
    echo "Powerline fonts already exist, skip this step."
    return 0;
  fi
  if [ -d "fonts" ]; then
    rm -rf fonts
  fi

  # clone
  git clone https://github.com/powerline/fonts.git
  # install
  cd fonts
  ./install.sh
  # clean-up a bit
  cd ..
  rm -rf fonts
}

# Vim plug installation functions

function install_vim_plug() {
  if [ -d "~/.vim/autoload/plug.vim" ]; then
    echo "vim-plug had already been installed, skip this step."
    return 0;
  fi

  # Download vim-plug into vim autoload directory
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing Powerline fonts"
    install_powerline_fonts;

    echo "Syncing the file to ~/ folder"
    doIt;
  fi;
fi;
unset doIt;
