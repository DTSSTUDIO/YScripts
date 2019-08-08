import argparse
import os

try:
    import colorama
    import pdfkit
    from colorama import Fore, Style, init
except ModuleNotFoundError as e:
    print(f"Gerekli modülleri yükleyin: 'python -m pip install {e.name}'")

init(autoreset=True)

# https://github.com/wkhtmltopdf/wkhtmltopdf/releases
# choco install wkhtmltopdf
path_wkthmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
config = pdfkit.configuration(wkhtmltopdf=path_wkthmltopdf)
css = r"C:\Users\Yedhrab\Desktop\workspace\markdown-pdf.css"

parser = argparse.ArgumentParser(description='HTML to PDF.')
parser.add_argument(
    '--input-dir',
    '-i',
    dest="inputDir",
    default=os.getcwd(),
    help='Path of html items',
    type=str,
)
parser.add_argument(
    '--output',
    "-o",
    dest="outDir",
    default="out",
    help='Pdf outputs destionation (default "out")',
)
parser.add_argument(
    '--css',
    "-c",
    dest="css",
    default=None,
    help='Custom css style for PDF (default None)',
)

args = parser.parse_args()

outDir = os.path.join(args.inputDir, args.outDir)
if not os.path.exists(outDir):
    os.mkdir(outDir)

for name in os.listdir(args.inputDir):
    if ".html" in name:
        _input = os.path.join(args.inputDir, name)
        _output = os.path.join(outDir, name.replace('.html', ''))

        print(Fore.CYAN + f"Converting: {_input}")

        try:
            if args.css is None:
                pdfkit.from_file(
                    f"{_input}", f"{_output}.pdf", configuration=config)
            else:
                pdfkit.from_file(f"{_input}", f"{_output}.pdf",
                                 configuration=config, css=css)
            print(Fore.GREEN + "Succes!")
        except Exception as e:
            print(Fore.YELLOW + f"Error while converting.")
