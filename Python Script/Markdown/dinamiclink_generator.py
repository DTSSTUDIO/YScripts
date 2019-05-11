"""Static linkleri dinamik hale getirme
"""

import time

FILE_PATH = r"/home/yemreak/Documents/YScripts/temp/Vscode.md"

links = []
filestr = ""
with open(FILE_PATH, "r") as file:
    delims = ['[', ']', '(', ')']
    for line in file:
        # Her ayıracın konum indeksi
        indexes = [-1 for i in range(len(delims))]

        # Satırları satır indeksiyle okuma
        index = 0
        for char in line:
            # Karakter '[' ise indeksini alma
            if char == delims[0]:
                indexes[0] = index

                # Diğer indeksleri sıfırlama
                for i in range(1, len(indexes)):
                    indexes[i] = -1

            # "[" karakteri bulunduysa diğer karakterleri arama
            elif indexes[0] != -1:
                # "]" karakteri ise indeksini alma
                if char == delims[1]:
                    indexes[1] = index

                # "]" karakteri alındıysa diğer karakterleri arama
                elif indexes[1] != -1:
                    # Karakter ')' ise ve ']' dan hemen sonra geliyorsa indeksini alma
                    if char == delims[2] and index == indexes[1] + 1:
                        indexes[2] = index

                    # '(' bulundusya diğer karakterleri arama
                    elif indexes[2] != -1:
                        # Karakter ")" ise indeksini alma ve ek işlemler
                        if char == delims[3]:
                            indexes[3] = index

                            # Linkleri ayrıştırma ve gerekli dizilere ekleme
                            linkstr = line[indexes[2] + 1:indexes[3]]

                            # Anchor linkleri atlama
                            if linkstr[0] != "#":
                                link_index = len(links)
                                found = False
                                for i, link in enumerate(links):
                                    if link == linkstr:
                                        link_index = i
                                        found = True
                                        break

                                # Link yoksa ekleme
                                if not found:
                                    links.append(linkstr)

                                # Parantezleri ve aradaki linki dinamikleştirme
                                line = line.replace(
                                    f"({linkstr})", f"[{link_index}]")

                                # Satır değişikliğini indekse yansıtma
                                index -= len(linkstr) - len(str(link_index))

                            # İndeksleri sıfırlama (yenisi için hazırlama)
                            indexes = [-1 for i in range(len(delims))]

                        # Boşluk karakteri link yapısını bozduğundan yeni link için hazırlama
                        elif char == ' ':
                            indexes = [-1 for i in range(len(delims))]

            # Yeni karaktere geçmeden önce indeksi ayarlama
            index += 1
        filestr += line

filestr += "\n"
for i, link in enumerate(links):
    filestr += f"\n[{i}]: {link}"

with open(FILE_PATH, "w") as file:
    file.write(filestr)
