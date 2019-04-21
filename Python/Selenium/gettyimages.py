from utils import *
from config import *

driver = initiate_driver()
urls = []

try:
    for i in range(PAGE):
        URL = PAGE_URL.format(i + 1)
        driver.get(URL)

        # İstenen öğe yüklenene kadar bekleme
        hold_driver(driver)

        # Script'i minimize etme ve derleme (Edilmezse çalışmaz)
        script = get_script()
        page_urls = driver.execute_script(script)
        urls += page_urls

        if DOWNLOAD:
            download_urls(urls)

        if DEBUG:
            print("Sayfada bulunan url sayısı: ", page_urls.__len__())
            print("Toplam Url Sayısı: ", urls.__len__())

finally:
    driver.close()

if WRITE_FILE:
    # Output dosyasına her url'i yazdırma
    write_array_to_file(OUTPUT_FILE, urls)
