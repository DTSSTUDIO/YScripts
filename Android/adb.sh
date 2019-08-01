echo "Kablosuz bağlatı kuruluyor... (Yaklaşık 7s sürer)"

# https://futurestud.io/tutorials/how-to-debug-your-android-app-over-wifi-without-root
adb kill-server &>/dev/null && 
adb tcpip 5555 &>/dev/null && 

# Bağlantıyı bekleme
sleep 3 &>/dev/null

# http://rapidprogrammer.com/how-to-get-android-ip-address-from-adb-commandline-shell
IP=$(adb shell ip addr show wlan0 | grep "inet\s" | awk '{print $2}' | awk -F'/' '{print $1}')

adb connect $IP:5555 &>/dev/null
echo "Bağlanıldı: $IP:5555"
echo "Ekranı kapatabilirsiniz, bağlantı bozulmayacaktır."
