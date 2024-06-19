#!/bin/bash

install_packages() {
    sudo pacman -S --noconfirm \
        tree sddm exa bat tmux fish zoxide i3 xorg xorg-server alacritty kitty rofi polybar gedit thunar gvfs udiskie mpv thunar-volman xdg-user-dirs \
        lxappearance thunar-archive-plugin xarchiver unzip tumbler ibus ibus-chewing pulseaudio pavucontrol flameshot feh \
        audacious audacious-plugins audacity blueman bluetuith-bin calibre chezmoi gnome-keyring gpick jdk-openjdk jdk17-openjdk jdk21-openjdk mousepad openvpn picom pigz starship

    yay -S --noconfirm \
        nordic-theme pulseaudio-control google-chrome grub2-theme-preview onlyoffice-bin insync visual-studio-code-bin \
        xclip yt-dlp ffmpeg zsh zsh-autosuggestions zsh-completions zsh-autocomplete zsh-syntax-highlighting zsh-vi-mode qt6ct polychromatic libreoffice-fresh obs-studio typora eog font-manager gimp \
        noto-fonts-cjk ttf-ms-win11-auto ttf-blex-nerd-font-git ttf-jetbrains-mono-nerd papirus-icon-theme ttf-iosevka-nerd ttf-ligaconsolas-nerd-font ttf-font-awesome adobe-source-code-pro-fonts ttf-font-awesome-5 \
        kvantum rxvt-unicode alsa-utils mate-power-manager nitrogen rofi python-pip binutils gcc make pkg-config fakeroot \
        fastfetch btop pywal-git calc mpd chrony networkmanager-dmenu-git \
        git lazygit zoxide ripgrep sqlite fd yarn lldb nvm make unzip neovim python-pynvim rustup

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

set_config() {
    cd ~
    git clone https://github.com/vinceliuice/grub2-themes.git
    cd grub2-themes
    sudo ./install.sh -t stylish -s 2k

    # sudo tar -czf ~/backup/sddm-sugar-candy.tar.gz -C /usr/share/sddm/themes sugar-candy
    cd ~
    if [[ -d /usr/share/sddm/themes/sugar-candy ]]; then
        sudo rm -rf /usr/share/sddm/themes/sugar-candy
    fi
    sudo mkdir -p /usr/share/sddm/themes/sugar-candy
    git clone https://github.com/zyrethor/sddm-sugar-candy
    cd sddm-sugar-candy
    sudo tar -xzf sddm-sugar-candy.tar.gz -C /usr/share/sddm/themes/sugar-candy


    sudo mkdir -p /etc/X11/xorg.conf.d
    sudo bash -c 'cat <<EOL > /etc/X11/xorg.conf.d/capslock-to-control.conf
Section "InputClass"
    Identifier "CapsLock to Control"
    MatchIsKeyboard "on"
    Option "XkbOptions" "ctrl:nocaps"
EndSection
EOL'


    sudo bash -c 'cat <<EOL > /etc/environment
_JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
QT_QPA_PLATFORMTHEME=qt6ct
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
INPUT_METHOD=fcitx
GLFW_IM_MODULE=ibus
EOL'


    sudo bash -c 'cat <<EOL > /etc/sddm.conf
[Theme]
Current=sugar-candy
EOL'

    sudo bash -c 'echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub'
    sudo bash -c 'echo "GRUB_FONT=/boot/grub/fonts/iosevka_nerd_font.pcf" >> /etc/default/grub'



    systemctl --user enable pulseaudio
    sudo systemctl enable sddm.service
    sudo systemctl enable iwd
    sudo systemctl enable bluetooth.service

    xdg-user-dirs-update
}


if [ $# -eq 0 ]; then
    install_packages
fi


while [[ "$#" -gt 0 ]]; do
    case $1 in
        --set-config | -s)
        set_config
        shift ;;
    esac
done
