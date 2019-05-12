"""Static linkleri dinamik hale getirme
"""

import time

FILE_PATH = r"/home/yemreak/Documents/YScripts/temp/Vscode.md"

# TODO: Fonksiyonel yapıyı kullan o daha hızlı, ve senin sevdiğin türde :D


def remove_staticlinks() -> str:
    DELIMS = ['[', ']', '(', ')']

    links = []
    filestr = ""

    def init_indexes(indexlist: list) -> list:
        return [-1 for i in range(len(DELIMS))]

    with open(FILE_PATH, "r") as file:

        for line in file:
            # Her ayıracın konum indeksi
            delim_indexes = init_indexes()

            # Satırları satır indeksiyle okuma
            index = 0
            for char in line:
                # Karakter '[' ise indeksini alma
                if char == DELIMS[0]:
                    delim_indexes[0] = index

                    # Diğer indeksleri sıfırlama
                    for i in range(1, len(delim_indexes)):
                        delim_indexes[i] = -1

                # "[" karakteri bulunduysa diğer karakterleri arama
                elif delim_indexes[0] != -1:
                    # "]" karakteri ise indeksini alma
                    if char == DELIMS[1]:
                        delim_indexes[1] = index

                    # "]" karakteri alındıysa diğer karakterleri arama
                    elif delim_indexes[1] != -1:
                        # Karakter ')' ise ve ']' dan hemen sonra geliyorsa indeksini alma
                        if char == DELIMS[2] and index == delim_indexes[1] + 1:
                            delim_indexes[2] = index

                        # '(' bulundusya diğer karakterleri arama
                        elif delim_indexes[2] != -1:
                            # Karakter ")" ise indeksini alma ve ek işlemler
                            if char == DELIMS[3]:
                                delim_indexes[3] = index

                                # Linkleri ayrıştırma ve gerekli dizilere ekleme
                                linkstr = line[delim_indexes[2] +
                                               1:delim_indexes[3]]

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
                                    index -= len(linkstr) - \
                                        len(str(link_index))

                                # İndeksleri sıfırlama (yenisi için hazırlama)
                                delim_indexes = init_indexes()

                            # Boşluk karakteri link yapısını bozduğundan yeni link için hazırlama
                            elif char == ' ':
                                delim_indexes = init_indexes()

                # Yeni karaktere geçmeden önce indeksi ayarlama
                index += 1
            filestr += line

    filestr += "\n"
    for i, link in enumerate(links):
        filestr += f"\n[{i}]: {link}"


with open(FILE_PATH, "w") as file:
    file.write(filestr)
