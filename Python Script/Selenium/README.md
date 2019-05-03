# Selenium <!-- omit in toc -->

İnternet üzerinden toplu resim indirmeyi sağlar.

## İçerikler <!-- omit in toc -->

> `Home` tuşu ile yukarı yönelebilirsin.

- [Gereklilikler](#gereklilikler)
- [Yapılandırma Ayarları](#yap%C4%B1land%C4%B1rma-ayarlar%C4%B1)
  - [Selenium Driver Sabitleri](#selenium-driver-sabitleri)
  - [Operatör Sabitleri](#operat%C3%B6r-sabitleri)
  - [Yükleme Sabitleri](#y%C3%BCkleme-sabitleri)
  - [Dosya İşlemleri Sabitleri](#dosya-i%CC%87%C5%9Flemleri-sabitleri)
  - [Sayfa Sabitleri](#sayfa-sabitleri)

## Gereklilikler

- Proje chrome üzerinden çalıştığı için uygun [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/home) indirilmelidir
  - Chromedriver'ın yolu `config.py` dosyasında belirtilmelidir

## Yapılandırma Ayarları

Yapılandırma ayarları `config.py` dosyasında bulunmaktadır.

### Selenium Driver Sabitleri

| Değişken             | Açıklama                  |
| -------------------- | ------------------------- |
| `CHROME_DRIVER_PATH` | Chromedriver dosya yolu   |
| `JS_PATH`            | Değer döndüren js dosyası |
| `ID_WAIT_CASE`       | Beklenecek elemanın ID'si |

### Operatör Sabitleri

| Değişken     | Açıklama                             |
| ------------ | ------------------------------------ |
| `DOWNLOAD`   | Bulunan urlleri indirir              |
| `WRITE_FILE` | Bulunan url'leri dosyaya yazar       |
| `DEBUG`      | Ekrana bilgilendirme çıktıları basar |

### Yükleme Sabitleri

| Değişken       | Açıklama                           |
| -------------- | ---------------------------------- |
| `DOWNLOAD`     | Bulunan urller indirilsin mi       |
| `DOWNLOAD_DIR` | Yükleme işleminin yapılacağı dizin |

### Dosya İşlemleri Sabitleri

| Değişken      | Açıklama                           |
| ------------- | ---------------------------------- |
| `WRITE_FILE`  | Bulunan url'leri dosyaya yazar     |
| `OUTPUT_FILE` | Resim url'lerinin yazılacağı dosya |

### Sayfa Sabitleri

| Değişken   | Açıklama                                      |
| ---------- | --------------------------------------------- |
| `PAGE`     | Kaç sayfa tekrar edeceğini bildirir           |
| `PAGE_URL` | Sayfa değerinin olduğu kısmın `{}` olduğu url |
