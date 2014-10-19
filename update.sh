#!/usr/bin/env bash

git pull
git submodule update --init

mkdir ~/.vim

ln -sf ~/.etc/Dotfiles/vim-files/autoload ~/.vim/autoload
ln -sf ~/.etc/Dotfiles/vim-files/bundle ~/.vim/bundle
ln -sf ~/.etc/Dotfiles/vim-files/vimrc ~/.vimrc

ln -sf ~/.etc/Dotfiles/misc/.ctags ~/.ctags
