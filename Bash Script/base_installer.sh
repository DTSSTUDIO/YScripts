clear
echo '---------------------------------------------------------'
echo 'Temel uygulamaların Kurulumu (Yunus Emre Ak)'
echo 'Ubuntu 19.04 Disco üzerinde denenmiştir.'
echo '---------------------------------------------------------'



read -p "Temel gereksinimleri kurmak ister misin (unrar, emoji-font, gnome-tweaks, flameshot [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Temel araçların kurulumu
    sudo apt install -y unrar, fonts-noto-color-emoji gnome-tweaks flameshot
fi

cd /tmp

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
         google-chrome https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/750/openweather/ https://extensions.gnome.org/extension/1162/emoji-selector/
    fi
fi

read -p "Yazılım araçlarını Kurmak ister misin (vscode ve git) [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # VsCode
    wget -O code.deb https://az764295.vo.msecnd.net/stable/51b0b28134d51361cf996d2f0a1c698247aeabd8/code_1.33.1-1554971066_amd64.deb
    sudo dpkg -i code.deb
    rm code.deb

    # Git Kurulumu
    sudo apt install -y git
fi

read -p "Miniconda3 kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Uyarı notu
    read -p "Çıkan ekranda özel bir ayarlama yapmayın, default değerleri tercih edin."
    
    # Miniconda3 Kurulumu
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash ./Miniconda3-latest-Linux-x86_64.sh
    rm Miniconda3-latest-Linux-x86_64.sh
    
    # Miniconda3 komutlarını tanımlama
    echo >> ~/.bashrc
    echo "# Miniconda3 Komutları" >> ~/.bashrc 
    echo alias "alias conda_init='source ~/miniconda3/bin/activate'" >> ~/.bashrc
    echo "Tanımlanan Miniconda3 komutları: conda_init"
fi

read -p "Nodejs kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    wget -qO- https://deb.nodesource.com/setup_11.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

read -p "Xammp kurmak ister misin [y/n] " # -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Bağlantı araçlarını kurma
    sudo apt install net-tools
    
    # Xammp indirme
    wget https://downloadsapachefriends.global.ssl.fastly.net/7.3.4/xampp-linux-x64-7.3.4-0-installer.run?from_af=true
    
    # Gerekli izinleri veerme ve kurma
    chmod 0755 xampp-linux-x64-7.3.4-0-installer.run
    sudo ./xampp-linux-x64-7.3.4-0-installer.run
    rm xampp-linux-x64-7.3.4-0-installer.run
        
    # Xammp komutlarını tanımlama
    echo >> ~/.bashrc
    echo "# Xampp Komutları" >> ~/.bashrc 
    echo alias "xampp_restart='sudo /opt/lampp/xampp restart'" >> ~/.bashrc
    echo alias "xampp_start='sudo /opt/lampp/xampp start'" >> ~/.bashrc
    echo alias "xampp_stop='sudo /opt/lampp/xampp stop'" >> ~/.bashrc
    echo "Tanımlanan Xampp komutları: xampp_restart, xampp_start ve xampp_stop"

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

# Clipboard Management
# sudo apt install -y copyq



