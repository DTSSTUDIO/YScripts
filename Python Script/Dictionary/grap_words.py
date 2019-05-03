import linecache
import codecs

# Yapılandırma değişkenleri
FILE_INPUTS = ["input.txt", "input1.dic"]
FILE_OUTPUT = "tr_TR.dic"
FIRST_LINES = [7, 1]


def get_line_count(filename):
    return sum(1 for _ in open(filename))  # Dosyadaki satır sayınını hesaplama


LAST_LINES = map(get_line_count, FILE_INPUTS)

# Dosyayı utf-8 formatında açma (yoksa oluşturma)
file_output = codecs.open(FILE_OUTPUT, 'w+', 'utf-8')
file_output.write(u'\ufeff')  # UTF-8 Etiketi yazma

# İndeks ve toplam satır değişkenleri
index_input = 0
total_line = 0

# Çıktıyı oluşturma
for last_line in LAST_LINES:
    # Her dosyayı çıktıya ekleme
    for i in range(FIRST_LINES[index_input], last_line):
        line = linecache.getline(FILE_INPUTS[index_input], i)  # Belli satırı okuma
        words = line.split()  # Satırı kelimelerine ayırma
        file_output.write(words[0] + '\n')

        total_line += 1
        print("Yazılan kelime & satır sayısı: " + total_line.__str__())

    index_input += 1

# Dosyayı kapatma
file_output.close()
