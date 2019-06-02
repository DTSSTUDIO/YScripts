# !/bin/bash
# Copyright © ~ Yunus Emre Ak

# Terminali temizleme
clear

echo '---------------------------------------------------------'
echo 'Format Sonrası Toplu Kurulum | Ubuntu 19.04 Disco'
echo 'Copyright © ~ Yunus Emre Ak'
echo '---------------------------------------------------------'

# Template oluşturma
touch ~/Templates/Text.txt
echo '#!/bin/bash' > ~/Templates/Script.sh

# Firefox Kaldırma
sudo apt --purge remove -y firefox*
sudo rm -rf ~/.mozilla /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons

# Paketleri güncelleme
sudo apt -y dist-upgrade
sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove

# Font terminalden yüklenmezse her uygulama görmüyor
sudo apt install -y unrar gnome-tweaks flameshot fonts-noto-color-emoji

# Chrome kurulumu
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
rm chrome.deb

# Gnome eklentileri
sudo apt install -y chrome-gnome-shell
sudo apt install -y gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-gtkclutter-1.0
google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep?hl=en https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/1162/emoji-selector/ https://extensions.gnome.org/extension/779/clipboard-indicator/

# Whatsapp kısayolunu oluşturma
mkdir -p ~/Pictures/Icons/
wget -O ~/Pictures/Icons/whatsapp-webapp.svg https://drive.google.com/uc?id=1orVT5TPEs84ua3HNC0kOXYSGoZyhSW1W
sudo bash -c 'echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=WhatsApp
GenericName=WhatsApp
Comment=WhatsApp desktop webapp
Exec=/opt/google/chrome/google-chrome --app=https://web.whatsapp.com/
Terminal=false
Type=Application
StartupNotify=true
MimeType=text/plain;
Icon=$(echo ~)/Pictures/Icons/whatsapp-webapp.svg
Categories=Network;Application;
Keywords=WhatsApp;webapp;
X-Ubuntu-Gettext-Domain=WhatsApp
StartupWMClass=web.whatsapp.com" > /usr/share/applications/whatsapp-webapp.desktop'

# Temel uygulamlar
sudo apt install -y cheese totem

# Git kurulumu
sudo apt install -y git git-lfs
git lfs install

read -p "Git e-postanızı girin (örn: yemreak@gmail.com) " # -n 1 -r
git config --global user.email "$REPLY"
read -p "Git için isminizi girin (örn: Yunus Emre) " # -n 1 -r
git config --global user.name "$REPLY"
git config --global credential.helper store

# OnlyOfficeDesktop paketinin indirilmesi
wget -O onlyofficedesktop.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb

# Paketin yüklenmesi (-f: --fix-broken)
sudo apt install -yf ./onlyofficedesktop.deb