# Kullanım şekli
# bash git_pusher.sh <path>
# bsah git_pusher.sh ~/Desktop

echo "---------------- '$1' yolu için git dosyaları github hesabına iteleniyor."
cd "$1"
for f in *; do # Her bir dosyayı $f'e atama
if [ -d "$f" ]; then # Dizin ise işleme alma
    cd "$f"
    echo "---------------- '$f' dizini iteleniyor. ----------------"
    git remote add origin https://github.com/yedhrab/$f.git
    git commit -m "Sistemi baştan oluşturma 🏗"
    git push origin master
    echo "---------------- '$f' dizini itelendi. ----------------"
    cd ..
fi
done
echo "---------------- '$1' yolu için iteleme tamamlandı. ----------------"


