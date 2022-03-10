#!/bin/bash

cd $HOME

#xorg, wm and compositor
sudo pacman -S xorg xorg-xinit xmonad xmonad-contrib xmobar picom feh

#basic apps
sudo pacman -S dmenu dunst exa fzf git htop mpv ncdu neofetch neovim pass qalculate-gtk tldr unzip wget which zathura zathura-pdf-poppler zoxide zsh zsh-completions

#development apps
#openjdk-jdk
sudo pacman -S gcc gdb python 

#font
sudo mkdir -p /usr/local/share/fonts/otf/
sudo mkdir -p /usr/local/share/fonts/ttf/

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip" -O Iosevka.zip
unzip Iosevka.zip -d Iosevka
rm Iosevka/*Windows*
sudo cp -R ./Iosevka /usr/share/fonts/ttf/
rm -rf Iosevka

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip" -O CodeNewRoman.zip
unzip CodeNewRoman.zip -d CodeNewRoman
rm CodeNewRoman/*Windows*
sudo cp -R ./CodeNewRoman /usr/share/fonts/otf/
rm -rf CodeNewRoman

fc-cache -fv


#st
git clone https://github.com/raghackerz/st.git st
cd st
make
sudo make install
cd

#copy dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/raghackerz/dotfiles-personal.git $HOME/.dotfiles/
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

chmod +x $HOME/.scripts/*
chsh -s /usr/bin/zsh

