# Url'leri taşıyan doyanın yolu
file="urls/dump.url"
prefix='img' # Ön ek
ext='.jpg' # Dosya uzantısı

url_counts() {
	i=0
	while IFS= read line
	do
		let "i += 1"
	done < "$file"
	return $i
}

dowload_with_name() {
	num=0 # Sayaç
	while IFS= read line
	do	
		wget -O "$prefix$num$ext" "$line"
		let "num += 1"
	done < "../$file"
}

url_counts
num=$?
if [ "$num" == "0" ]; then
	exit
fi

read -p "$num tane resim 'images' dizini içerisine yüklenecektir (eskileri 'backup' dosyasına taşınacak). [y/n] " # -n 1 -r
case $REPLY in 
	[Yy]* ) {
		date=$(date)
		mkdir -p images "backup/$date"
		cd images
		mv * "../backup/$date"
		dowload_with_name
	};;
	[Nn]* ) {
		echo "İndirme iptal edildi."
	};;
esac