# !/bin/bash

# Pencere yönetim scripti
# WM_CLASS'ı verilen uygulamayı aynı masaüstü üzerinde oluşturur | açar | gizler.
# $1, WM_CLASS
# $2, Varsa özel derlenecek komut
# Copyright © ~ Yunus Emre Ak

# Detaylı açıklama `docs/ywm.md` dosyasındadır.

# # Yetki verilemzse çalışmaz
# chmod u+x '~/Documents/YScripts/Shell Script/ywm.sh'

# Windows ID'sini alma ve varsa
if [ ${#1} -gt 0 ]; then
    # Sadece aktif masaüstünde arama
    WID=$(xdotool search --desktop $(xdotool get_desktop) --classname $1)
    if [ ${#WID} -gt 0 ]; then
        # Birden fazla varsa odaklandığımı bulma ve gizleme
        if [[ "$WID" =~ "$(xdotool getwindowfocus)" ]]; then
            xdotool windowminimize $(xdotool getwindowfocus)
        else
            # Odaklandığım yoksa önce 1.yi olmazsa 2.yi açma
            let "WID1 = $(echo $WID | awk '{print $1}')"
            let "WID2 = $(echo $WID | awk '{print $2}')"
            xdotool windowactivate $WID1 || xdotool windowactivate $WID2
        fi
    else
        # Özel komut girilirse onu, girilmezse WM_CLASS'ı gerçekleştir
        if [ ${#2} -gt 0 ]; then
            $2
        else
            $1
        fi
    fi
else
    echo "'WM_CLASS' ve bulunamazsa isteğe bağlı 'Derlenecek komut' girilmelidir"
    echo "Örn: 'bash ywm.sh chrome google-chrome'"
fi

# Dosyanın indirilmesi
# wget -O '~/Documents/YScripts/Shell Script/ywm.sh' 'https://raw.githubusercontent.com/yedhrab/YScripts/master/Shell%20Script/ywm.sh'

# Temel kısayollar
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh gnome-terminal" # SUPER + 1
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh google-chrome" # SUPER + 2
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh code" # SUPER + 3
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh nautilus" # SUPER + 4
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh gedit" # SUPER + 4
# bash -c "bash ~/Documents/YScripts/Shell\ Script/ywm.sh 'web.whatsapp.com' '/opt/google/chrome/google-chrome --app=https://web.whatsapp.com/'" # SUPER + W
