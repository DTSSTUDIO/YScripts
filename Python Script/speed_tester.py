import time

TEST_COUNT = 1000

FILE_PATH = r"/home/yemreak/Documents/YScripts/temp/Vscode.md"


def replace_static_links_from_file() -> str:
    DELIMS = ('[', ']', '(', ')')
    NOT_FOUND = -1
    LINKS = []

    def init_indexes() -> list:
        nonlocal DELIMS
        return [-1 for i in range(len(DELIMS))]

    def reset_indexes(indexlist: list, start: int = 0) -> list:
        """İndeksleri sıfırlama

        Args:
            indexlist (list): İndex listesi
            start (int, optional): Başlangıç indeksi. Defaults to 0.

        Returns:
            list: Değiştirilen indeksler
        """

        nonlocal NOT_FOUND
        for i in range(start, len(indexlist)):
            indexlist[i] = NOT_FOUND

        return indexlist

    def grablink(line: str, indexes: list) -> str:
        """Verilen satırdaki linki alma

        Args:
            line (str): Satır
            indexes (list): Ayıraçların indeksleri

        Returns:
            str: Link metni
        """
        return line[indexes[2] + 1:indexes[3]]

    def replace_line(line: str, link: str, index: int) -> (str, int):
        """Satırdaki linki dinamikleştirme

        Args:
            line (str): Satır
            link (str): Link metni
            link_index (int): Link indeksi

        Returns:
            ((str, int)): Yeni satır ve yeni indeks değeri
        """

        def reg_link(linkstr: str) -> int:
            """Link kayıtlı değil koşula göre kayıt altına alma

            Args:
                linkstr (str): Link metni
                condition (str, optional): Koşul metni. Defaults to "".

            Returns:
                int: Kayıt altına alınan linkin indeksi
            """
            nonlocal LINKS

            link_index = len(LINKS)
            found = False
            for i, link in enumerate(LINKS):
                if link == linkstr:
                    link_index = i
                    found = True
                    break

            # Link yoksa ekleme
            if not found:
                LINKS.append(linkstr)

            return link_index

        # Anchor linkleri atlama
        if link[0] != "#":
            link_index = reg_link(link)

            line = line.replace(f"({link})", f"[{link_index}]")
            index -= len(link) - len(str(link_index))

        return line, index

    filestr = ""
    with open(FILE_PATH, "r") as file:

        for line in file:
            # Her ayıracın konum indeksini tanımlama
            delim_indexes = init_indexes()

            # Satırları satır indeksiyle okuma
            index = 0
            for char in line:
                # Karakter '[' ise indeksini alma
                if char == DELIMS[0]:
                    delim_indexes[0] = index

                    # Diğer indeksleri sıfırlama
                    delim_indexes = reset_indexes(delim_indexes, 1)

                # "[" karakteri bulunduysa diğer karakterleri arama
                elif delim_indexes[0] != NOT_FOUND:
                    # "]" karakteri ise indeksini alma
                    if char == DELIMS[1]:
                        delim_indexes[1] = index

                    # "]" karakteri alındıysa diğer karakterleri arama
                    elif delim_indexes[1] != NOT_FOUND:
                        # Karakter ')' ise ve ']' dan hemen sonra geliyorsa indeksini alma
                        if char == DELIMS[2] and index == delim_indexes[1] + 1:
                            delim_indexes[2] = index

                        # '(' bulundusya diğer karakterleri arama
                        elif delim_indexes[2] != NOT_FOUND:
                            # Karakter ")" ise indeksini alma ve ek işlemler
                            if char == DELIMS[3]:
                                delim_indexes[3] = index

                                # Linkleri ayrıştırma ve gerekli dizilere ekleme
                                linkstr = grablink(line, delim_indexes)

                                # Parantezleri ve aradaki linki dinamikleştirme, indeksi yenileme
                                line, index = replace_line(
                                    line, linkstr, index)

                                # İndeksleri sıfırlama (yenisi için hazırlama)
                                delim_indexes = reset_indexes(delim_indexes)

                            # Boşluk karakteri link yapısını bozduğundan yeni link için hazırlama
                            elif char == ' ':
                                delim_indexes = reset_indexes(delim_indexes)

                # Yeni karaktere geçmeden önce indeksi ayarlama
                index += 1
            filestr += line

    filestr += "\n"
    for i, link in enumerate(LINKS):
        filestr += f"\n[{i}]: {link}"

    with open(FILE_PATH, "w") as file:
        file.write(filestr)


def old_scriot():
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
                                    index -= len(linkstr) - \
                                        len(str(link_index))

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


def measure_speed(func1, func2, number: int):

    def measure_time(func, number) -> float:
        first_time = time.time()
        for i in range(number):
            func()
        return time.time() - first_time

    print(f"Fonksiyonlar kıyaslanıyor...",
          func1.__name__, " vs ", func2.__name__)
    time1 = measure_time(func1, number)
    time2 = measure_time(func2, number)
    func1_faster_ratio = (time2 / time1 - 1) * 100
    if func1_faster_ratio > 0:
        print(f"{func1.__name__} %" + "%.2f daha hızlı" % func1_faster_ratio)
    else:
        print(f"{func2.__name__} %" + "%.2f daha hızlı" % -func1_faster_ratio)


if __name__ == "__main__":
    measure_speed(replace_static_links_from_file, old_scriot, TEST_COUNT)
