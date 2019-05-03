# Url'leri taşıyan doyanın yolu
file="urls/dump.url"
prefix='img' # Ön ek
ext='.jpg' # Dosya uzantısı

read_file() {
	num=0
	file='$prefix$num$ext'
	str=''
	while IFS= read line
	do
		let "str += $line"
	done < "$img_file"
}

read_file