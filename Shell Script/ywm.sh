# !/bin/bash

# Pencere yönetim scripti
# Copyright © ~ Yunus Emre Ak
# $1, Başlık ismi
# $2, Derlenecek komut


# Windows ID'sini alma ve varsa
WID=$(xdotool search --name $1)
echo $WID 
if [ "${#WID}" -gt 0 ]; then
    if [ $WID == "$(xdotool getwindowfocus)" ]; then
        echo a 
        xdotool windowminimize $WID
    else
        xdotool windowactivate $WID
    fi
else
    $2
fi
