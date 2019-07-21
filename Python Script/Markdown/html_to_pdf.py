import argparse
import pdfkit
import os

# https://github.com/wkhtmltopdf/wkhtmltopdf/releases
path_wkthmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
config = pdfkit.configuration(wkhtmltopdf=path_wkthmltopdf)

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
        help='Clear the log file on startup.Default is No',
        )

args = parser.parse_args()
for name in os.listdir(args.inputDir):
    name = os.path.join(args.inputDir, name)
    if ".html" in name:
        output = os.path.join(args.outDir, name.replace('.html', ''))
        pdfkit.from_file(f"{name}", f"{output}.pdf", configuration=config)
