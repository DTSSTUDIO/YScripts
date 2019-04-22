# Kullanım şekli
# bash git_fixer.sh <path>
# bsah git_fixer.sh ~/Desktop

echo "---------------- '$1' yolu için git dosyaları temizleniyor. ----------------"
cd "$1"
for f in *; do # Her bir dosyayı $f'e atama
if [ -d "$f" ]; then # Dizin ise işleme alma
    cd "$f"
    echo "---------------- '$f' dizinindeki git dosyaları temizleniyor. ----------------"
    rm -rf .git
    echo "---------------- '$f' dizinindeki git dosyaları temizlendi. ----------------"
    cd ..
fi
done
echo "---------------- '$1' yolu için temizleme tamamlandı. ----------------s"


