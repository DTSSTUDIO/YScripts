# !/bin/bash

# Pencere yönetim scripti
# Copyright © ~ Yunus Emre Ak
# Not: İsmi ve yolu önemlidir yconfiguration ile kullanılır
# $1, Başlık ismi
# $2, Derlenecek komut

# Windows ID'sini alma ve varsa
if [ ${#1} -gt 0 ]; then
    WID=$(xdotool search --name $1)
    if [ ${#WID} -gt 0 ]; then
        if [ $WID == "$(xdotool getwindowfocus)" ]; then
            xdotool windowminimize $WID
        else
            xdotool windowactivate $WID
        fi
    else
        $2
    fi
else
    echo "'Başlık ismi' ve bulunamazsa 'Derlenecek komut' girilmelidir"
    echo "Örn: 'bash ywm.sh chrome google-chrome'"
fi
