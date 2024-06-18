#!/bin/bash

echo "Install packages..."
sudo pacman -S tmux fish zoxide i3 xorg xorg-server alacritty kitty rofi polybar gedit thunar gvfs udiskie mpv thunar-volman xdg-user-dirs --noconfirm

yay -S lxappearance nordic-theme thunar-archive-plugin xarchiver unzip tumbler pulseaudio-control google-chrome ibus ibus-chewing pulseaudio pavucontrol flameshot feh --noconfirm

yay -S audacious audacious-plugins audacity blueman bluetuith-bin calibre chezmoi gnome-keyring gpick grub2-theme-preview jdk-openjdk jdk17-openjdk jdk21-openjdk mousepad onlyoffice-bin openvpn picom pigz insync starship ttf-ligaconsolas-nerd-font visual-studio-code-bin xclip yt-dlp ffmpeg zsh zsh-autocomplete zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-vi-mode qt5ct polychromatic libreoffice-fresh obs-studio typora typora eog font-manager gimp nordic-theme --noconfirm

yay -S noto-fonts-cjk ttf-ms-win11-auto ttf-blex-nerd-font-git ttf-jetbrains-mono-nerd papirus-icon-theme ttf-iosevka-nerd --noconfirm

yay -S rxvt-unicode alsa-utils mate-power-manager nitrogen rofi python-pip ttf-font-awesome adobe-source-code-pro-fonts binutils gcc make pkg-config fakeroot ttf-font-awesome-5 --noconfirm

yay -S neofetch btop pywal-git calc mpd chrony networkmanager-dmenu-git --noconfirm

yay -S git lazygit zoxide ripgrep sqlite fd yarn lldb nvm make unzip neovim python-pynvim --noconfirm

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
sudo ./install.sh -t stylish -s 2k
cd

systemctl --user enable pulseaudio

xdg-user-dirs-update
