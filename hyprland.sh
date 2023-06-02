#!/bin/bash

cd $HOME

# TODO: add support to recieve packages list from a file.

# hyprland
sudo pacman -S --needed wayland hyprland wl-clipboard waybar

#basic apps
sudo pacman -S --needed wofi dunst exa fzf git htop libnotify mpv ncdu neofetch neovim pass qalculate-gtk tldr ttf-linux-libertine unzip wget which zathura zathura-pdf-mupdf zoxide zsh zsh-completions ripgrep kitty

#development apps
#openjdk-jdk
sudo pacman -S --needed gcc gdb python 

#font
sudo mkdir -p /usr/local/share/fonts/otf/
sudo mkdir -p /usr/local/share/fonts/ttf/

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip" -O Iosevka.zip
unzip Iosevka.zip -d Iosevka
rm Iosevka/*Windows*
sudo cp -R ./Iosevka /usr/local/share/fonts/ttf/
rm -rf Iosevka

# TODO: replace CodeNewRoman with JetbrainsMono
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip" -O CodeNewRoman.zip
unzip CodeNewRoman.zip -d CodeNewRoman
rm CodeNewRoman/*Windows*
sudo cp -R ./CodeNewRoman /usr/local/share/fonts/otf/
rm -rf CodeNewRoman

fc-cache -fv


#phinger cursor
git clone https://aur.archlinux.org/phinger-cursors.git
cd phinger-cursors
makepkg -si
cd

sudo ln -s /usr/share/icons/phinger-cursors/cursors /usr/share/icons/default/cursors

#copy dotfiles
# alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/raghackerz/dotfiles-personal.git $HOME/.dotfiles/
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

# TODO: add suport for passwords folder.

chmod +x $HOME/.scripts/*
chsh -s /usr/bin/zsh

