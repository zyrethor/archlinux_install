#!/bin/bash

echo "Install packages..."
sudo pacman -S exa bat tmux fish zoxide i3 xorg xorg-server alacritty kitty rofi polybar gedit thunar gvfs udiskie mpv thunar-volman xdg-user-dirs --noconfirm

yay -S lxappearance nordic-theme thunar-archive-plugin xarchiver unzip tumbler pulseaudio-control google-chrome ibus ibus-chewing pulseaudio pavucontrol flameshot feh --noconfirm

yay -S audacious audacious-plugins audacity blueman bluetuith-bin calibre chezmoi gnome-keyring gpick grub2-theme-preview jdk-openjdk jdk17-openjdk jdk21-openjdk mousepad onlyoffice-bin openvpn picom pigz insync starship ttf-ligaconsolas-nerd-font visual-studio-code-bin --noconfirm

yay -S xclip yt-dlp ffmpeg zsh zsh-autocomplete zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-vi-mode qt6ct polychromatic libreoffice-fresh obs-studio typora typora eog font-manager gimp nordic-theme --noconfirm

yay -S noto-fonts-cjk ttf-ms-win11-auto ttf-blex-nerd-font-git ttf-jetbrains-mono-nerd papirus-icon-theme ttf-iosevka-nerd --noconfirm

yay -S kvantum rxvt-unicode alsa-utils mate-power-manager nitrogen rofi python-pip ttf-font-awesome adobe-source-code-pro-fonts binutils gcc make pkg-config fakeroot ttf-font-awesome-5 --noconfirm

yay -S fastfetch btop pywal-git calc mpd chrony networkmanager-dmenu-git --noconfirm

yay -S git lazygit zoxide ripgrep sqlite fd yarn lldb nvm make unzip neovim python-pynvim --noconfirm

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd
sudo mkdir -p /etc/X11/xorg.conf.d
cd /etc/X11/xorg.conf.d
sudo bash -c 'cat <<EOL > test.conf
Section "InputClass"
    Identifier "CapsLock to Control"
    MatchIsKeyboard "on"
    Option "XkbOptions" "ctrl:nocaps"
EndSection
EOL'
cd


bash -c 'cat <<EOL > /etc/environment
#
# This file is parsed by pam_env module
#
# Syntax: simple "KEY=VAL" pairs on separate lines
#

_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
QT_QPA_PLATFORMTHEME="qt6ct"
EOL'


cd
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
sudo ./install.sh -t stylish -s 2k
cd

echo "[Theme]" > /etc/sddm.conf
echo "Current=sugar-candy" >> /etc/sddm.conf

# sudo tar -czf ~/backup/sugar-candy.tar.gz -C /usr/share/sddm/themes sugar-candy
cd
git clone https://github.com/zyrethor/sddm-sugar-candy
cd sddm-sugar-candy
sudo tar -xzf sugar-candy.tar.gz -C /usr/share/sddm/themes
cd

systemctl --user enable pulseaudio

xdg-user-dirs-update
