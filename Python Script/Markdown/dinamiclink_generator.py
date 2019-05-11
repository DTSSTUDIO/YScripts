"""Static linkleri dinamik hale getirme
"""

FILE_PATH = r"/home/yemreak/Documents/YScripts/temp/Vscode.md"


link_count = 0

delims = ['[', ']', '(', ')']

filestr = ""
with open(FILE_PATH, "r") as file:
    internal_links = []
    external_links = []
    for l, line in enumerate(file, 1):
        # İndeksler []()
        indexes = [-1, -1, -1, -1]
        for index, char in enumerate(line, 1):
            if char == delims[0]:  # Karakter '[' ise
                indexes[0] = index

                # Arama sürecini sıfırlama
                for i in range(1, len(indexes)):
                    indexes[i] = -1

            elif indexes[0] != -1:  # '[' bulunduysa
                if char == delims[1]:  # Karakter '[' ise
                    indexes[1] = index

                elif indexes[1] != -1:  # ']' bulunduysa
                    # Karakter ')' ise ve ']' dan hemen sonra geliyorsa
                    if char == delims[2] and index == indexes[1] + 1:
                        indexes[2] = index
                    elif indexes[2] != -1:  # '(' bulundusya
                        # TODO: Boşluk varsa iptal etmeyi ekle
                        if char == delims[3]:
                            indexes[3] = index

                            # Link'i ekleme
                            # TODO: Linkleri ayrıştır
                            linkstr = line[indexes[2]:indexes[3] - 1]
                            if "http" in linkstr:
                                external_links.append(linkstr)
                            else:
                                internal_links.append(linkstr)

                            # İndeksleri sıfırlama (yenisi için hazırlama)
                            indexes = [-1, -1, -1, -1]

    print("Harici linkler:", len(external_links))
    for link in external_links:
        print(link)

    print("Dahili linkler:", len(internal_links))
    for link in internal_links:
        print(link)
