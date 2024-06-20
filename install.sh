#!/bin/bash

install_packages() {
    sudo pacman -S --noconfirm \
        tree sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg exa bat tmux fish zoxide i3 xorg xorg-server alacritty kitty rofi polybar gedit thunar gvfs udiskie mpv thunar-volman xdg-user-dirs \
        lxappearance thunar-archive-plugin xarchiver unzip tumbler ibus ibus-chewing pulseaudio pavucontrol flameshot feh thefuck lxsession \
        audacious audacious-plugins audacity blueman calibre chezmoi gnome-keyring gpick mousepad openvpn picom pigz starship

    yay -S --noconfirm \
        bluetuith-bin bluez bluez-utils nordic-theme pulseaudio-control grub2-theme-preview \
        xclip yt-dlp ffmpeg zsh zsh-autosuggestions zsh-completions zsh-autocomplete zsh-syntax-highlighting zsh-vi-mode qt6ct typora eog font-manager gimp \
        noto-fonts-cjk ttf-ms-win11-auto ttf-jetbrains-mono-nerd papirus-icon-theme ttf-iosevka-nerd ttf-ligaconsolas-nerd-font ttf-font-awesome adobe-source-code-pro-fonts ttf-font-awesome-5 \
        kvantum rxvt-unicode alsa-utils mate-power-manager nitrogen rofi python-pip binutils gcc make pkg-config fakeroot \
        fastfetch btop pywal-git calc mpd chrony dmenu networkmanager-dmenu-git gdu evince ncmpcpp timidity++ \
        fzf cmake ninja curl git lazygit zoxide ripgrep sqlite fd yarn lldb nvm make unzip python-pynvim rustup \
        fcitx5 fcitx5-chewing fcitx5-chinese-addons fcitx5-configtool fcitx5-qt

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_additional_packages() {
    yay -S --noconfirm \
        jdk-openjdk jdk17-openjdk jdk21-openjdk google-chrome onlyoffice-bin insync visual-studio-code-bin \
        polychromatic libreoffice-fresh obs-studio ttf-blex-nerd-font-git
}

set_config() {
    mkdir -p ~/.mpd/playlists

    # curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    # omf install eclm

    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    sudo grub-mkfont -s 32 -o /boot/grub/fonts/iosevka_nerd_font.pcf /usr/share/fonts/TTF/IosevkaNerdFontMono-Regular.ttf

    cd ~
    if [[ -d grub2-themes ]]; then
        rm -rf grub2-themes
    fi
    git clone https://github.com/vinceliuice/grub2-themes.git
    cd grub2-themes
    sudo ./install.sh -t stylish -s 2k

    # sudo tar -czf ~/backup/sddm-sugar-candy.tar.gz -C /usr/share/sddm/themes sugar-candy
    cd ~
    if [[ -d /usr/share/sddm/themes/sugar-candy ]]; then
        sudo rm -rf /usr/share/sddm/themes/sugar-candy
    fi
    if [[ -d sddm-sugar-candy ]]; then
        rm -rf sddm-sugar-candy
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
    systemctl --user enable mpd
    sudo systemctl enable sddm.service
    sudo systemctl enable iwd
    sudo systemctl enable bluetooth.service

    xdg-user-dirs-update

    chezmoi init --apply zyrethor
    fc-cache -fv
    ls -l /bin/sh
}


if [ $# -eq 0 ]; then
    install_packages
fi


while [[ "$#" -gt 0 ]]; do
    case $1 in
        --set-config | -s)
        set_config
        shift ;;
        --install_additional | -a)
        install_additional_packages
        shift ;;
    esac
done
