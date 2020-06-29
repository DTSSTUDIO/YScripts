# sudo apt install wkhtmltopdf

pandoc --from=markdown_mmd+yaml_metadata_block+smart --standalone \
--to=html -V css=/home/yedhrab/Projects/YScripts/Makefile/markdown-pdf.css \
--output=README.html README.md --metadata pagetitle="README"

wkhtmltopdf -B 25mm -T 25mm -L 25mm -R 25mm \
-q -s Letter README.html README.pdf
