# Terminali temizleme
clear

echo '---------------------------------------------------------'
echo "Temel uygulamaların Kurulumu ~ Yunus Emre Ak"
echo 'Ubuntu 19.04 Disco üzerinde denenmiştir.'
echo '---------------------------------------------------------'
echo "Önerilen Uygulamalar: VLC ve zenkit (github to-do kısmı gibi)"
echo '---------------------------------------------------------'

# Temp dizinine kurulum yapma, hata durumunda silinir.
cd /tmp

read -p "Temel gereksinimleri kurmak ister misin (unrar, emoji-font, gnome-tweaks, flameshot [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Temel araçların kurulumu
    sudo apt install -y unrar fonts-noto-color-emoji gnome-tweaks flameshot
fi

read -p "Medya oynatıcısı kurmak ister misin? (vlc) [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Medya oynatıcısı kurulumu
    sudo apt install vlc
fi

read -p "System bakım aracı kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # System Organizer
    wget -O stacer.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb
    sudo dpkg -i stacer.deb 
    rm stacer.deb
fi

read -p "Chrome Kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Chrome
    wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i chrome.deb
    rm chrome.deb
    
    
    read -p "Gnome eklentilerinin chrome üzerinden yönetimini aktif etmek ister misin [y/n] " # -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Gnome Ektensions
        sudo apt install -y chrome-gnome-shell
        sudo apt-get install gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-gtkclutter-1.0
        google-chrome https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/750/openweather/ https://extensions.gnome.org/extension/1162/emoji-selector/ https://extensions.gnome.org/extension/779/clipboard-indicator/ https://extensions.gnome.org/extension/690/easyscreencast/
    fi
fi

read -p "Firefox'u kaldırmak ister misin? [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt --purge remove -y firefox*
fi

read -p "Mail yönetim uygulaması kurmak ister misin? (mailspring) [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget -O mailspring.deb https://updates.getmailspring.com/download?platform=linuxDeb
    sudo dpkg -i  mailspring.deb
    sudo apt install --fix-broken
    sudo dpkg -i  mailspring.deb
    rm mailspring.deb
fi

read -p "Office uygulamlarını kurmak ister misin? (onlyofficedesktop) [y/n]"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # OnlyOfficeDesktop paketinin indirilmesi
    wget -O onlyofficedesktop.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb

    # Paketin yüklenmesi
    sudo dpkg -i onlyofficedesktop.deb

    # Yükleme sırasında hata olursa gereksinimleri kurma
    sudo apt install -f

    # Tekrar ndeneme
    sudo dpkg -i onlyofficedesktop.deb
fi

read -p "Dünyanın en sık kullanılan text editörü olan VsCode'u kurmak ister misin? [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # VsCode
    wget -O code.deb https://az764295.vo.msecnd.net/stable/51b0b28134d51361cf996d2f0a1c698247aeabd8/code_1.33.1-1554971066_amd64.deb
    sudo dpkg -i code.deb
    rm code.deb
fi

read -p "Git ve Git Large File Support kurulumunu yapmak ister misin? [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Git ve Git-lfs Kurulumu
    sudo apt install -y git git-lfs
    git lfs install
fi

read -p "Python için yönetim araçlarının kurulumunu yapmak ister misin? (pip3, pylint ve autopep8) [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt install -y python3-pip
    pip3 install pylint autopep8
fi

read -p "Sudo ile 'alias' desteğini aktif etmek ister misin? [y/n]"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "# Sudo ile yeni komutların kullanılmasını sağlar" >> ~/.bashrc
    echo "# https://askubuntu.com/a/22043/898692" >> ~/.bashrc
    echo "alias sudo='sudo '" >> ~/.bashrc
fi

read -p "Miniconda3 kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
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

    conda config --set auto_activate_base false
    echo "Tanımlanan komutlar: conda"
    echo "Conda'yı aktif/pasif işlemleri için:  activate ve conda deactivate"
    
fi

read -p "Xammp kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Bağlantı araçlarını kurma
    sudo apt install net-tools
    
    # Xammp indirme
    wget -O xampp-linux-x64-7.3.4-0-installer.run https://downloadsapachefriends.global.ssl.fastly.net/7.3.4/xampp-linux-x64-7.3.4-0-installer.run?from_af=true
    
    # Gerekli izinleri veerme ve kurma
    chmod +x xampp-linux-x64-7.3.4-0-installer.run
    sudo ./xampp-linux-x64-7.3.4-0-installer.run
    rm xampp-linux-x64-7.3.4-0-installer.run

    read -p "Xammp komutları tanımlansın mı (xampp ve mysql) [y/n] " # -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        # Xammp komutlarını tanımlama
        echo >> ~/.bashrc
        echo "# Xampp Komutları" >> ~/.bashrc 
        echo alias xampp='/opt/lampp/xampp' >> ~/.bashrc
        echo alias mysql='/opt/lampp/bin/mysql' >> ~/.bashrc      
        echo "Tanımlanan komutlar: xampp ve mysql"
    fi    
fi


# Clipboard Management
# sudo apt install -y copyq

read -p "Wine kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
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
    sudo apt install --install-recommends winehq-stable
    # sudo apt install --install-recommends winehq-devel
    # sudo apt install --install-recommends winehq-staging
fi

read -p "Nodejs kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget -qO- https://deb.nodesource.com/setup_11.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

read -p "Postgresql kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo apt-get install postgresql

    read -p "PostgreSQL JDBC Driver indirmek ister misin? [y/n] " # -n 1 -r
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
        sudo apt-get install libpostgresql-jdbc-java libpostgresql-jdbc-java-doc
		echo "export CLASSPATH=$CLASSPATH:/usr/share/java/postgresql-42.2.5.jar" >> ~/.bashrc
    fi
fi

