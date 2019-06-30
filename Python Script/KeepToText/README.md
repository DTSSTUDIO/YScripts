# KeepToText

Google Takeout zip dosyalarını Evernote veya CintaNotes formatına çevirme.

> Takeout.zip dosyasında **sadece** keep notlarının olması gerekmekte.

## Kullanım

- Basit kullanım: `python keepToText.py zipFile`
- Tam kullanım: `python keepToText.py [-h] [--encoding ENCODING] [--system-encoding] [--format {Evernote,CintaNotes}] zipFile`

```sh
python keepToText.py --encoding "utf-8-sig" --format Evernote takeout-20190630T094457Z-001.zip
```

> Varsayılan olarak tüm çıktıları aynı dizinde `Text` dizini oluşturup içine atar.

## Ayarlar

- `--encoding` Formatlama ayarıdır
  - `--system-encoding` ayarı ile sistemin varsayılan codecleri kullanılır
  - Varsayılanı `utf-8`'dir
  - Evernote için `utf-8-sig` kullanın

## Modül Bağımlılıkları

| Format     | Bağımlılık                  |
| ---------- | --------------------------- |
| Evernote   | HTMLParser                  |
| CintaNotes | lxml, mako, python-dateutil |

> İndirmek için: `python -m pip install <bağımlılık>`
