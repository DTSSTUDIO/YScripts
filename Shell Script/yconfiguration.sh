# !/bin/bash

# Pencere yönetim scripti
# Copyright © ~ Yunus Emre Ak

# Dosyanın indirilmesi
wget -O '~/Documents/YScripts/Shell Script/ywm.sh' 'https://raw.githubusercontent.com/yedhrab/YScripts/master/Shell%20Script/ywm.sh'

# Yetki verilemzse çalışmaz
chmod u+x '~/Documents/YScripts/Shell Script/ywm.sh'

bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh 'what' '/opt/google/chrome/google-chrome --app=https://web.whatsapp.com/'"
