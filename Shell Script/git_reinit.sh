# Kullanım şekli
# bash git_reinit.sh <path>
# bsah git_reinit.sh ~/Desktop

echo "---------------- '$1' yolu için git tanımlanıyor. ----------------"
cd "$1"
for f in *; do # Her bir dosyayı $f'e atama
if [ -d "$f" ]; then # Dizin ise işleme alma
    cd "$f"
    echo "---------------- '$f' dizini için git yeniden tanımlanıyor. ----------------"
    rm -rf .git
    git init
    git add .
    git commit -m "Sistemi baştan oluşturma 🏗"
    echo "---------------- '$f' dizini için git yeniden tanımlandı. ----------------"
    cd ..
fi
done
echo "---------------- '$1' yolu için düzenlenme tamamlandı. ----------------"


