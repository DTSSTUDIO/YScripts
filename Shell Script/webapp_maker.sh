# !/bin/bash
# Copyright © ~ Yunus Emre Ak

# Terminali temizleme
clear

echo ""
echo '---------------------------------------------------------'
echo "Uygulama oluşturucu ~ Yunus Emre Ak"
echo 'Ubuntu 19.04 Disco üzerinde denenmiştir.'
echo 'Çıkmak için (CTRL + C) tuşuna basabilirsin.'
echo '---------------------------------------------------------'
echo ""

sudo bash -c '
read -p "Uygulama İsmi: " name
read -p "Uygulama urli: " url
read -p "Uygulama ikon yolu: " icon
echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=$name
GenericName=$name
Comment=$name desktop webapp
Exec=/opt/google/chrome/google-chrome --app=$url
Terminal=false
Type=Application
StartupNotify=true2
MimeType=text/plain;
Icon=$icon
Categories=Network;Application;
Keywords=Evernote;webapp;
X-Ubuntu-Gettext-Domain=$name
StartupWMClass=$url" > /usr/share/applications/$name-webapp.desktop
echo "$name başlatıcısı oluşturuldu 🎉"
'
