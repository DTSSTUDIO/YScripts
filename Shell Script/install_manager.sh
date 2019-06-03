# !/bin/bash
# Copyright © ~ Yunus Emre Ak

# Terminali temizleme
clear

echo '---------------------------------------------------------'
echo "Temel uygulamaların Kurulumu ~ Yunus Emre Ak"
echo 'Ubuntu 19.04 Disco üzerinde denenmiştir.'
echo 'Çıkmak için (CTRL + C) tuşuna basabilirsin.'
echo '---------------------------------------------------------'

# Renk ayarları
xrandr --output eDP-1 --set "Broadcast RGB" "Full"

while true; do
    read -p "Paketleri yenilemek ister misin? (update, upgrade, dist-upgrade) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt -y dist-upgrade
            sudo apt -y update
            sudo apt -y upgrade
            sudo apt -y autoremove
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do
    read -p "Dosya yöneticisi sağ tık menüsüne kalıpları eklemek ister misin? (Script.sh, text vs.) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            touch ~/Templates/Text.txt
            echo '#!/bin/bash' > ~/Templates/Script.sh
            break
        };;
        [Nn]* ) break;;
    esac
done

# Temp dizinine kurulum yapma, hata durumunda silinir.
cd /tmp

while true; do
    read -p "Temel gereksinimleri kurmak ister misin? (unrar, emoji-font, gnome-tweaks, flameshot [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            # Font terminalden yüklenmezse her uygulama görmüyor
            sudo apt install -y unrar gnome-tweaks flameshot fonts-noto-color-emoji
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Gömülü oyunları ve reklamları kaldırmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt remove -y --purge aisleriot* gnome-mahjongg gnome-mines 
            sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop /usr/share/unity-webapps/userscripts/unity-webapps-amazon/Amazon.user.js /usr/share/unity-webapps/userscripts/unity-webapps-amazon/manifest.json
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Chrome Kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo apt install -yf ./chrome.deb
            rm chrome.deb

            while true; do 
                read -p "Gnome eklentilerinin chrome üzerinden yönetimini aktif etmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        # Gnome Ektensions
                        sudo apt install -y chrome-gnome-shell
                        sudo apt install -y gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-gtkclutter-1.0
                        google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep?hl=en https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/750/openweather/ https://extensions.gnome.org/extension/1162/emoji-selector/ https://extensions.gnome.org/extension/779/clipboard-indicator/ https://extensions.gnome.org/extension/690/easyscreencast/

                        break
                    };;
                    [Nn]* ) break;;
                esac
            done

            while true; do 
                read -p "Firefox'u kaldırmak ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt --purge remove -y firefox*
                        sudo rm -rf ~/.mozilla /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons
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
    read -p "Whatsapp WebApp kısayol oluşturmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
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
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Telegram kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y telegram-desktop
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Paint alternatifi resim yönetim uygulamasını kurmak ister misin? (kolourpaint) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* )  {
            sudo apt install -y kolourpaint
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Resim yönetim uygulamasını kurmak ister misin? (shotwell) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y shotwell
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Kamera uygulamasını kurmak ister misin? (cheese) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y cheese
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Gnoem varsayılan (Totem) medya oynatıcısını kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y totem # Video codec ubuntu-restricted-extras 
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "VLC Medya oynatıcısı kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y vlc

            while true; do 
                read -p "Totem medya oynatıcısını kaldırmak ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt remove --purge totem
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
    read -p "System bakım aracı kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            wget -O stacer.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb
            sudo apt install -yf ./stacer.deb 
            rm stacer.deb
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Mail yönetim uygulaması kurmak ister misin? (snap ile kurulur) [y/n] " # -n 1 -r
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
    read -p "Thunderbird'i kaldırmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt --purge remove -y *thunderbird*
            break
        };;
        [Nn]* ) break;;
    esac
done


while true; do 
    read -p "Office uygulamlarını kurmak ister misin? (onlyofficedesktop) [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # OnlyOfficeDesktop paketinin indirilmesi
            wget -O onlyofficedesktop.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb

            # Paketin yüklenmesi (-f: --fix-broken)
            sudo apt install -yf ./onlyofficedesktop.deb
            rm onlyofficedesktop.deb

            while true; do
                read -p "Libreoffice'i kaldırmak ister misin? [y/n] "
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt remove --purge libreoffice*

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
    read -p "VsCode'u (dünyanın en sık kullanılan text editörünü) kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # VsCode
            wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
            sudo apt install -yf ./code.deb
            rm code.deb

            while true; do
                read -p "Fira Code indirmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* )  {
                        wget "https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip"
                        unzip FiraCode_1.206.zip -d "./Fira Code 1.206"
                        rm FiraCode_1.206.zip
                        mv Fira\ Code\ 1.206/ $HOME/.fonts
                        fc-cache
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
    read -p "Git ve Git Large File Support kurulumunu yapmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # Git ve Git-lfs Kurulumu
            sudo apt install -y git git-lfs
            git lfs install

            read -p "Git e-postanızı girin (örn: yemreak@gmail.com) " # -n 1 -r
            git config --global user.email "$REPLY"
            read -p "Git için isminizi girin (örn: Yunus Emre) " # -n 1 -r
            git config --global user.name "$REPLY"

            while true; do 
                read -p "Git kimlik bilgileri saklansın mı? (her defasında yazmayı engeller) [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        git config --global credential.helper store
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
    read -p "Python için yönetim araçlarının kurulumunu yapmak ister misin? (pip3, pylint ve autopep8) [y/n] " # -n 1 -r
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
    read -p "Sudo ile 'alias' desteğini aktif etmek ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            echo "# Sudo ile yeni komutların kullanılmasını sağlar" >> ~/.bashrc
            echo "# https://askubuntu.com/a/22043/898692" >> ~/.bashrc
            echo "alias sudo='sudo '" >> ~/.bashrc
            
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Miniconda3 kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            # Uyarı notu
            read -p "Çıkan ekranda özel bir ayarlama yapmayın, default değerleri tercih edin. (son kisma 'yes' deyin)"

            # Miniconda3 Kurulumu
            wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
            bash ./Miniconda3-latest-Linux-x86_64.sh
            rm Miniconda3-latest-Linux-x86_64.sh

            # Miniconda3 komutlarını tanımlama
            # echo >> ~/.bashrc
            # echo "# Miniconda3 Komutları" >> ~/.bashrc 
            # echo alias "alias conda_init='source ~/miniconda3/bin/activate'" >> ~/.bashrc
            # echo "Tanımlanan Miniconda3 komutları: conda_init"
			
			source ~/.bashrc
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
    read -p "Torrent yöneticisi kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y transmission-gtk
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Usb oluşturucusu kurmak ister misin? [y/n] " # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
           sudo apt install -y usb-creator-gtk
            break
        };;
        [Nn]* ) break;;
    esac
done

while true; do 
    read -p "Xammp kurmak ister misin? [y/n] " # -n 1 -r
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
		        read -p "Xammp komutları tanımlansın mı (xampp ve mysql) [y/n] " # -n 1 -r
		        case $REPLY in
		            [Yy]* ) {
		                # Xammp komutlarını tanımlama
		                echo >> ~/.bashrc
		                echo "# Xampp Komutları" >> ~/.bashrc 
		                echo alias xampp='/opt/lampp/xampp' >> ~/.bashrc
		                echo alias mysql='/opt/lampp/bin/mysql' >> ~/.bashrc      
		                echo "Tanımlanan komutlar: xampp ve mysql"

		                break 
		            };;
		            [Nn]* ) break;;
		        esac
            done

            while true; do
		        read -p "Wordpress kurmak ister misin? [y/n] " # -n 1 -r
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
    read -p "Wine kurmak ister misin? [y/n] " # -n 1 -r
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
    read -p "Nodejs kurmak ister misin? [y/n]" # -n 1 -r
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
    read -p "Figma kurmak ister misin? [y/n]" # -n 1 -r
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
    read -p "Postgresql kurmak ister misin? [y/n]" # -n 1 -r
    case $REPLY in 
        [Yy]* ) {
            sudo apt install -y postgresql

            while true; do 
                read -p "PostgreSQL JDBC Driver indirmek ister misin? [y/n] " # -n 1 -r
                case $REPLY in 
                    [Yy]* ) {
                        sudo apt install -y libpostgresql-jdbc-java libpostgresql-jdbc-java-doc
		                echo "export CLASSPATH=$CLASSPATH:/usr/share/java/postgresql-42.2.5.jar" >> ~/.bashrc

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

# Artııkları temizleme
sudo apt autoremove
