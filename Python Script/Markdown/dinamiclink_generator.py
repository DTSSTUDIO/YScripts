"""Static linkleri dinamik hale getirme
"""

import os

PRIVATES = {'.git', '.vscode'}


def is_private(name: str) -> bool:
    """İsmi verilen gizli mi kontrolü

    Args:
        name (str): Dosya ismi

    Returns:
        bool: Gizli ise `True` değilse `False`
    """

    for private in PRIVATES:
        if name == private:
            return True
    return False


def listfolderpaths(path: str = os.getcwd(), sort: bool = False) -> list:
    """Dizinleri listeleme

    Args:
        path (str, optional): Dizinleri listelenecek dizin. Defaults to os.getcwd().

    Returns:
        list: Listenelenen dizinler
    """

    folderlist = []
    for name in os.listdir(path):
        pathname = os.path.join(path, name)
        if os.path.isdir(pathname) and not is_private(name):
            folderlist.append(pathname)

    if sort:
        folderlist.sort()

    return folderlist


def listfilepaths(path: str = os.getcwd(), sort: bool = False) -> list:
    """Dosyaları listeleme

    Args:
        path (str, optional): Dosyaları listelenecek dizin. Defaults to os.getcwd().

    Returns:
        list: Listenelenen dosyalar
    """

    filelist = []
    for name in os.listdir(path):
        pathname = os.path.join(path, name)
        if os.path.isfile(pathname) and not is_private(name):
            filelist.append(pathname)

    if sort:
        filelist.sort()

    return filelist


def apply_all_files(func, path: str = os.getcwd(), sort: bool = False):
    for filepath in listfilepaths(path, sort):
        filepath = os.path.join(path, filepath)
        func(filepath)

    for folderpath in listfolderpaths(path, sort):
        folderpath = os.path.join(path, folderpath)
        apply_all_files(func, path=folderpath, sort=sort)


def apply_all_folders(func, path: str = os.getcwd(), sort: bool = False):
    for folderpath in listfolderpaths(path, sort):
        folderpath = os.path.join(path, folderpath)
        func(folderpath)
        apply_all_folders(func, path=folderpath, sort=sort)


def replace_static_links_from_file(filepath) -> str:
    # Markdownlar için çalışacak
    if '.md' not in filepath:
        return

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
        if len(link) > 0 and link[0] != "#":
            link_index = reg_link(link)

            line = line.replace(f"({link})", f"[{link_index}]")
            index -= len(link) - len(str(link_index))

        return line, index

    def append_header(filestr: str) -> str:
        if len(LINKS) > 0:
            if filestr[len(filestr) - 1] != "\n":
                filestr += "\n"

            filestr += "\n<!--DynamicLinks-->\n"

        return filestr

    def append_links(filestr: str):
        if len(LINKS) > 0:
            filestr += "\n"

            for i, link in enumerate(LINKS):
                filestr += f"[{i}]: {link}\n"

        return filestr

    filestr = ""
    with open(filepath, "r") as file:

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

    filestr = append_header(filestr)
    filestr = append_links(filestr)

    with open(filepath, "w") as file:
        file.write(filestr)


if __name__ == "__main__":
    apply_all_files(replace_static_links_from_file, sort=True)
