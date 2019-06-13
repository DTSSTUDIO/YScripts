import pdfkit
import os

# https://github.com/wkhtmltopdf/wkhtmltopdf/releases
path_wkthmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
config = pdfkit.configuration(wkhtmltopdf=path_wkthmltopdf)

for name in os.listdir():
    if ".html" in name:
        output = os.path.join("out", name.replace('.html', ''))
        pdfkit.from_file(f"{name}", f"{output}.pdf", configuration=config)
