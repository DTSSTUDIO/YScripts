# !/bin/bash
# Copyright © ~ Yunus Emre Ak

# Terminali temizleme
clear

echo ""
echo '---------------------------------------------------------'
echo "Temel uygulamaların Kurulumu ~ Yunus Emre Ak"
echo 'Ubuntu 19.04 Disco üzerinde denenmiştir.'
echo 'Çıkmak için (CTRL + C) tuşuna basabilirsin.'
echo '---------------------------------------------------------'
echo ""

# Renk ayarları
# xrandr --output eDP-1 --set "Broadcast RGB" "Full"

while true; do 
    read -p "- Chrome kurmak ister misin (Firefox kaldırılması ileride sorulacaktır)? [y/n]" # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &> /dev/null
            sudo apt install -yf ./chrome.deb &> /dev/null
            rm chrome.deb &> /dev/null
            
            echo "Chrome kurulumu tamamlandı 🎉"
            echo ""
            
            while true; do 
                read -p "- Gnome eklentilerinin chrome üzerinden yönetimini aktif etmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        # Gnome Ektensions
                        sudo apt install -y chrome-gnome-shell &> /dev/null
                        sudo apt install -y gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-gtkclutter-1.0 &> /dev/null
                        google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep?hl=en https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/750/openweather/ https://extensions.gnome.org/extension/1162/emoji-selector/ https://extensions.gnome.org/extension/779/clipboard-indicator/ https://extensions.gnome.org/extension/690/easyscreencast/ &> /dev/null
                        echo "Eklentiler aktif 🎉"
                        echo ""
                        
                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            while true; do 
                read -p "- Firefox'u kaldırmak ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt --purge remove -y firefox* &> /dev/null
                        sudo rm -rf $HOME/.mozilla /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons &> /dev/null
                        
                        echo "Firefox kaldırıldı 🎉"
                        echo ""
                        
                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do
    read -p "- Paketleri yenilemek ister misin? (update, upgrade, dist-upgrade) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt -y dist-upgrade &> /dev/null
            sudo apt -y update &> /dev/null
            sudo apt -y upgrade &> /dev/null
            sudo apt -y autoremove &> /dev/null
            
            echo "Paketler yenilendi 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do
    read -p "- Dosya yöneticisi sağ tık menüsüne kalıpları eklemek ister misin? (sh, txt, py vs.) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            touch $HOME/Templates/Text.txt
            echo "#!/bin/bash" > $HOME/Templates/Script.sh
            echo "#!/usr/bin/python" > $HOME/Templates/Script.py
            echo "Artık dizinlere sağ tıklyarak text veya script dosyası oluşturabilirsin 🎉"
            echo ""
             
            break
        };;
        [Nn]* ) break;;
    esac
done

# Temp dizinine kurulum yapma, hata durumunda silinir.
cd /tmp

while true; do
    read -p "- Temel gereksinimleri kurmak ister misin? (unrar, emoji-font, gnome-tweaks, flameshot, NTFS desteği, GTK canberra [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            # Font terminalden yüklenmezse her uygulama görmüyor
            sudo apt install -y unrar gnome-tweaks flameshot fonts-noto-color-emoji ntfs-3g libcanberra-gtk-module &> /dev/null
            
            echo "Artık emoji kullanabilir, özelleştirme yapabilir ve rar dosyalarını ayrıştırabilirsin 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do
    read -p "- Copyq ile clipboard yönetimi sağlamak ister misin [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            # Font terminalden yüklenmezse her uygulama görmüyor
            sudo apt install -y copyq &> /dev/null
            
            echo "Artık clipboard geçmisine bakabilir, onu kontrol edebilirsin 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Gömülü oyunları ve reklamları kaldırmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt remove -y --purge aisleriot* gnome-mahjongg gnome-mines &> /dev/null
            sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop /usr/share/unity-webapps/userscripts/unity-webapps-amazon/Amazon.user.js /usr/share/unity-webapps/userscripts/unity-webapps-amazon/manifest.json &> /dev/null
            
            echo "Rahatsız edici reklamlar defnedildi ☠"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Chrome WhatsApp kısayolu oluşturmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            mkdir -p $HOME/Pictures/Icons/Svg &> /dev/null
            wget -O $HOME/Pictures/Icons/Svg/whatsapp_webapp.svg https://drive.google.com/uc?id=1V5nqM6ocfWVcL682JtvT7urMBkVtGl2k &> /dev/null
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
Icon=$(echo $HOME/Pictures/Icons/Svg/whatsapp_webapp.svg)
Categories=Network;Application;
Keywords=WhatsApp;webapp;
X-Ubuntu-Gettext-Domain=WhatsApp
StartupWMClass=web.whatsapp.com" > /usr/share/applications/whatsapp-webapp.desktop'

            echo "Whatsapp kısayolu oluşturuldu 🎉"
            echo ""            
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Chrome GoogleÇeviri kısayolu oluşturmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            mkdir -p $HOME/Pictures/Icons/Png &> /dev/null
            wget -O $HOME/Pictures/Icons/Png/google_translate.png https://upload.wikimedia.org/wikipedia/commons/d/db/Google_Translate_Icon.png &> /dev/null
            sudo bash -c 'echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=GoogleTranslate
GenericName=GoogleTranslate
Comment=GoogleTranslate desktop webapp
Exec=/opt/google/chrome/google-chrome --app=https://translate.google.com/#view=home&op=translate&sl=auto&tl=tr
Terminal=false
Type=Application
StartupNotify=true2
MimeType=text/plain;
Icon=$(echo $HOME/Pictures/Icons/Png/google_translate.png)
Categories=Network;Application;
Keywords=GoogleTranslate;webapp;
X-Ubuntu-Gettext-Domain=GoogleTranslate
StartupWMClass=translate.google.com" > /usr/share/applications/chrome-webapp.desktop'

            echo "GoogleÇeviri kısayolu oluşturuldu 🎉"
            echo ""            
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Chrome Evernote kısayolu oluşturmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            mkdir -p $HOME/Pictures/Icons/Png &> /dev/null
            wget -O $HOME/Pictures/Icons/Png/evernote.png http://www.wikizero.biz/index.php?q=aHR0cHM6Ly91cGxvYWQud2lraW1lZGlhLm9yZy93aWtpcGVkaWEvY29tbW9ucy90aHVtYi9hL2E0L0V2ZXJub3RlX0ljb24ucG5nLzIyMHB4LUV2ZXJub3RlX0ljb24ucG5n &> /dev/null
            sudo bash -c 'echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=Evernote
GenericName=Evernote
Comment=Evernote desktop webapp
Exec=/opt/google/chrome/google-chrome --app=https://www.evernote.com/client/web
Terminal=false
Type=Application
StartupNotify=true2
MimeType=text/plain;
Icon=$(echo $HOME/Pictures/Icons/Png/evernote.png)
Categories=Network;Application;
Keywords=Evernote;webapp;
X-Ubuntu-Gettext-Domain=Evernote
StartupWMClass=www.evernote.com" > /usr/share/applications/evernote-webapp.desktop'

            echo "Evernote kısayolu oluşturuldu 🎉"
            echo ""            
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Tusk (evernote yönetim uygulaması) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget https://github.com/klaussinani/tusk/releases/download/v0.23.0/tusk_0.23.0_amd64.deb &> /dev/null
            sudo apt install -yf ./tusk_0.23.0_amd64 &> /dev/null
            
            echo "Tusk kurulumu tamamlandı 🎉"
            echo "" 
            
            break
        };;
        [Nn]* ) break;;
    esac
done


while true; do 
    read -p "- Telegram kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y telegram-desktop &> /dev/null
            
            echo "Telagram kurulumu tamamlandı 🎉"
            echo "" 
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Kolourpaint (paint alternatifi resim yönetim uygulaması) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt install -y kolourpaint &> /dev/null
            
            echo "Kolourpaint kurulumu tamamlandı 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Cheese (kamera uygulaması) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y cheese &> /dev/null
            
            echo "Cheese kurulumu tamamlandı 🎉"
            echo ""
            
            break           
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Totem (gnome varsayılan medya oynatıcısı) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y totem &> /dev/null # Video codec ubuntu-restricted-extras 
            
            echo "Totem kurulumu tamamlandı 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Shotwell (resim yönetim uygulaması) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y shotwell &> /dev/null
            
            echo "Shotwell kurulumu tamamlandı 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- VLC Medya oynatıcısı kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y vlc &> /dev/null

            while true; do 
                read -p "- Totem medya oynatıcısını kaldırmak ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt remove --purge totem &> /dev/null
                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- System bakım aracı kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -O stacer.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb &> /dev/null
            sudo apt install -yf ./stacer.deb &> /dev/null
            rm stacer.deb &> /dev/null
            
            echo "Bakım aracı kuruldu 🎉"
            echo ""
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Mail yönetim uygulaması kurmak ister misin? (snap ile kurulur) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
            # sudo apt install -yf  ./mailspring.deb
            # rm mailspring.deb
            sudo snap install mailspring

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Thunderbird'i kaldırmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt --purge remove -y *thunderbird*
            break
        };;
        [Nn]* ) break;;
    esac
done


while true; do 
    read -p "- Office uygulamlarını kurmak ister misin? (onlyofficedesktop) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # OnlyOfficeDesktop paketinin indirilmesi
            wget -O onlyofficedesktop.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb &> /dev/null

            # Paketin yüklenmesi (-f: --fix-broken)
            sudo apt install -yf ./onlyofficedesktop.deb &> /dev/null
            rm onlyofficedesktop.deb &> /dev/null

            echo "OnlyOfficeDesktop kurulumu tamamlandı 🎉"
            echo ""            
            
            while true; do
                read -p "- Libreoffice'i kaldırmak ister misin? [y/n] "
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt remove --purge libreoffice* &> /dev/null

                        echo "Libreoffice defnedildi ☠"
                        echo ""                          
                        
                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done


while true; do 
    read -p "- VsCode'u (dünyanın en sık kullanılan text editörünü) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # VsCode
            wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868 &> /dev/null
            sudo apt install -yf ./code.deb &> /dev/null
            rm code.deb &> /dev/null
            
            echo "VsCode kuruldu, artık kodlayabilirsin 👨‍💻👩‍💻"
            echo ""

            while true; do
                read -p "- Fira Code indirmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* )  {
                        wget "https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip" &> /dev/null
                        unzip FiraCode_1.206.zip -d "./Fira Code 1.206" &> /dev/null
                        rm FiraCode_1.206.zip &> /dev/null
                        mv Fira\ Code\ 1.206/ $HOME/.fonts &> /dev/null
                        fc-cache &> /dev/null
                        
                        echo "'Fira Code' adlı programlama fontun var, 'font.ligeratures' ayarını aktif etmeyi unutma 👨‍💻👩‍💻"
                        echo ""
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Git ve Git Large File Support kurulumunu yapmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # Git ve Git-lfs Kurulumu
            wget -O "$HOME/Downloads/script.deb.sh" "https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh"
            sudo bash "$HOME/Downloads/script.deb.sh"
            sudo apt install -y git git-lfs &> /dev/null
            git lfs install &> /dev/null
            rm "$HOME/Downloads/script.deb.sh" &> /dev/null

            read -p "- Git e-postanızı girin (örn: yemreak@gmail.com) " # -n 1 -r
            git config --global user.email "$REPLY"
            read -p "- Git için isminizi girin (örn: Yunus Emre) " # -n 1 -r
            git config --global user.name "$REPLY"
            
            echo "Git ve Git-Lfs kurulumu tamamlandı 🎉"
            echo ""

            while true; do 
                read -p "- Git kimlik bilgileri saklansın mı? (her defasında yazmayı engeller) [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        git config --global credential.helper store
                        
                        echo "Artık git bilgileri kayıt ediliyor 🗃"
                        echo ""
                        
                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- YWM pencere yönetim scriptimi yüklemek ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y xdotool &> /dev/null

            mkdir -p "$HOME/Tools" &> /dev/null
            wget -O "$HOME/Tools/ywm.sh" https://raw.githubusercontent.com/yedhrab/YScripts/master/Shell%20Script/ywm.sh &> /dev/null
            sudo chmod u+x $HOME/Tools/ywm.sh

            echo "Pencere yönetim scripti indirildi 🌪"
            echo ""

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Python için yönetim araçlarının kurulumunu yapmak ister misin? (pip3, pylint ve autopep8) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y python3-pip
            pip3 install pylint autopep8

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Sudo ile 'alias' desteğini aktif etmek ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            echo "# Sudo ile yeni komutların kullanılmasını sağlar" >> $HOME/.bashrc
            echo "# https://askubuntu.com/a/22043/898692" >> $HOME/.bashrc
            echo "alias sudo='sudo '" >> $HOME/.bashrc
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Miniconda3 kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # Uyarı notu
            read -p "- Çıkan ekranda özel bir ayarlama yapmayın, default değerleri tercih edin. (son kisma 'yes' deyin)"

            # Miniconda3 Kurulumu
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
            bash ./Miniconda3-latest-Linux-x86_64.sh
            rm Miniconda3-latest-Linux-x86_64.sh

            # Miniconda3 komutlarını tanımlama
            # echo >> $HOME/.bashrc
            # echo "# Miniconda3 Komutları" >> $HOME/.bashrc 
            # echo alias "alias conda_init='source $HOME/miniconda3/bin/activate'" >> $HOME/.bashrc
            # echo "Tanımlanan Miniconda3 komutları: conda_init"
			
			source $HOME/.bashrc
            $HOME/miniconda3/bin/conda config --set auto_activate_base false config --set auto_activate_base false
            $HOME/miniconda3/bin/conda deactivate
            echo "Tanımlanan komutlar: conda"
            echo "Conda'yı aktif/pasif işlemleri için:  activate ve conda deactivate"

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Torrent yöneticisi kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y transmission-gtk
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Usb oluşturucusu kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
           sudo apt install -y usb-creator-gtk
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Xammp kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # Bağlantı araçlarını kurma
            sudo apt install -y net-tools

            # Xammp indirme
            wget -O xampp-linux-x64-7.3.4-0-installer.run https://downloadsapachefriends.global.ssl.fastly.net/7.3.4/xampp-linux-x64-7.3.4-0-installer.run?from_af=true

            # Gerekli izinleri veerme ve kurma
            chmod +x xampp-linux-x64-7.3.4-0-installer.run
            sudo ./xampp-linux-x64-7.3.4-0-installer.run
            rm xampp-linux-x64-7.3.4-0-installer.run

            while true; do
		        read -p "- Xammp komutları tanımlansın mı (xampp ve mysql) [y/n] " # -n 1 -r
		        case $REPLY in
		            [Yy]* ) {
		                # Xammp komutlarını tanımlama
		                echo >> $HOME/.bashrc
		                echo "# Xampp Komutları" >> $HOME/.bashrc 
		                echo alias xampp='/opt/lampp/xampp' >> $HOME/.bashrc
		                echo alias mysql='/opt/lampp/bin/mysql' >> $HOME/.bashrc      
		                echo "Tanımlanan komutlar: xampp ve mysql"

		                break 
		            };;
		            [Nn]* ) break;;
		        esac
            done

            while true; do
		        read -p "- Wordpress kurmak ister misin? [y/n] " # -n 1 -r
		        case $REPLY in
		            [Yy]* ) {
                        # Wordpress indirilmesi
                        wget -O wordpress.zip https://wordpress.org/latest.zip

                        # Wordpress'i çıkartma ve taşıma
                        unizp wordpress.zip
                        sudo mv wordpress /opt/lampp/htdocs

                        # Dosyaya okuma ve yazma erişimi verme
                        sudo chmod -R 777 /opt/lampp/htdocs/wordpress/

                        # Wordpress sayfasına yönelendirme
                        sudo /opt/lampp/xampp start
                        google-chrome localhost/phpmyadmin localhost/wordpress 

		                echo "XAMPP'ı başlatıp 'localhost/wordpress' adresi üzerinden wordpress'e erişebilirin."

		                break 
		            };;
		            [Nn]* ) break;;
		        esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Wine kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # 32bit desteğini açma
            sudo dpkg --add-architecture i386

            # Güvenlik anahtarı ekleme
            wget -nc https://dl.winehq.org/wine-builds/winehq.key
            sudo apt-key add winehq.key
            rm winehq.key

            # Repoyu ekleme
            sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ cosmic main'
            sudo apt update

            # Sürüm seçimi
            sudo apt install -y --install-recommends winehq-stable
            # sudo apt install --install-recommends winehq-devel
            # sudo apt install --install-recommends winehq-staging

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Nodejs kurmak ister misin? [y/n]" # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -qO- https://deb.nodesource.com/setup_12.x | sudo -E bash -
            sudo apt install -y nodejs

            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Figma kurmak ister misin? [y/n]" # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -O https://github.com/ChugunovRoman/figma-linux/releases/download/v0.5.1/figma-linux_0.5.1_amd64.deb
            
            sudo apt install -yf ./figma-linux_0.5.1_amd64.deb
            rm figma-linux_0.5.1_amd64.deb
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "- Postgresql kurmak ister misin? [y/n]" # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y postgresql

            while true; do 
                read -p "- PostgreSQL JDBC Driver indirmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt install -y libpostgresql-jdbc-java libpostgresql-jdbc-java-doc
		                echo "export CLASSPATH=$CLASSPATH:/usr/share/java/postgresql-42.2.5.jar" >> $HOME/.bashrc

                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            break
        };;
        [Nn]* ) break;;
    esac
done

# Artıkları temizleme
sudo apt autoremove &> /dev/null

echo ""
echo "Artık dosyalar temizlendi, kurulum sonlandırıldı. Görüşürüz 🐣"
echo "~ YEmreAk"
echo ""
