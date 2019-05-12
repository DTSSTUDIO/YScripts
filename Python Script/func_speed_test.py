from time import time

# Obje uzunluğu
RANGE = 1000

# Toplam test sayısı
TEST_RANGE = 10000

# Fonksiyonun yavaş kaldığı testlerin sayısı
func_slow_count = 0

# Objeyi oluşturma
data1 = [i for i in range(RANGE)]
data2 = [i for i in range(RANGE)]
data3 = [i for i in range(RANGE)]

avg_func_speed = 0
for test in range(TEST_RANGE):
    first_time = time()

    # Normal işleme
    data = []
    for test2 in range(len(data1)):
        data.append(data1[test2])
    for test2 in range(len(data2)):
        data.append(data2[test2])
    for test2 in range(len(data3)):
        data.append(data3[test2])

    normal_time = time() - first_time

    # Fonksiyon ile işleme
    def fdata(data1, data2, data3):
        data = []
        for test2 in range(len(data1)):
            data.append(data1[test2])
        for test2 in range(len(data2)):
            data.append(data2[test2])
        for test2 in range(len(data3)):
            data.append(data3[test2])
        return data

    data = [i for i in range(RANGE)]

    first_time = time()

    # Fonksiyon ile veri atama
    fdata = fdata(data1, data2, data3)

    func_time = time() - first_time

    if normal_time - func_time < 0:
        func_slow_count += 1

    avg_func_speed = (
        avg_func_speed * test + (normal_time / func_time - 1) * 100
    ) / (test + 1)

print("Fonksiyon işlemi normalden %" + "%.2f daha hızlı, testlerde " % avg_func_speed + "%" + "%.2f ihtimalle yavaş kalmıştır." %
      (func_slow_count * 100 / TEST_RANGE))
