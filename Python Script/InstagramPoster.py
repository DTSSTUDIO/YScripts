"""Instagramda Otomatik Foto Paylaşma
"""

from pynput.mouse import Button as Button, Controller as MController, Listener as MListener
from pynput.keyboard import Key, Controller as KController, Listener as KListener
import time
import os

# TODO Son alınan verileri config'e kaydet

WAIT_LONG = 7
WAIT_SHORT = 1

LOG_FILE = "instaposter.log"
# CONFIG_FILE = "poster.cfg"

mouse = MController()
keyboard = KController()


def configure_positions():

    def on_first_click(x, y, button, pressed):
        global POSITION_PLUS
        POSITION_PLUS = (x, y)

        # Dinlemeyi kapatma
        if not pressed:
            return False

    def on_second_click(x, y, button, pressed):
        global POSITION_NEXT
        POSITION_NEXT = (x, y)

        # Dinlemeyi kapatma
        if not pressed:
            return False

    def on_press(key):
        if key == Key.alt:
            return False

    def get_indexes():
        global START_INDEX, FINISH_INDEX
        try:
            if 'START_INDEX' not in globals():
                START_INDEX = int(input("Dosya başlangıç indeksi: "))
            if 'FINISH_INDEX' not in globals():
                FINISH_INDEX = int(input("Dosyanın bitiş indeksi: "))
        except:
            get_indexes()

    os.system("clear")
    print("--------------------------------------------------------------------")
    print("Yapılacak işlemi programa tanıtmak için bir kez el ile gerçekleyin:")
    print("1. Hazır olduğunuzda 'ALT' tuşu ile similasyonu başlatın")
    print("2. '+' butonuna tıklayın")
    print("3. Resimlerinin bulunduğu dizine gelin ve başlangıç ve bitiş indekslerini girin")
    print("4. Başlangıç resmini seçin, 'Next' butonu aşamasına geldiğinizde 'ALT' tuşuna basın")
    print("5. 'Next' butonuna tıklayın")
    print("--------------------------------------------------------------------")

    with KListener(on_press=on_press) as klistener:
        klistener.join()

    print("\n'+' butonuna tıklayın")

    with MListener(on_click=on_first_click) as mlistener:
        mlistener.join()

    print("\nResimlerinin bulunduğu dizine gelin ve başlangıç ve bitiş indekslerini girin")

    get_indexes()

    print("\nBaşlangıç resmini seçin, 'Next' butonu aşamasına geldiğinizde 'ALT' tuşuna basın")

    with KListener(on_press=on_press) as klistener:
        klistener.join()

    print("\nNext butonuna tıklayın")

    with MListener(on_click=on_second_click) as mlistener:
        mlistener.join()

    print("\nKordinatlar başarıyla alındı")
    print("--------------------------------------------------------------------")


def touch_plus_button():
    mouse.position = POSITION_PLUS
    mouse.click(Button.left)


def select_file(index):
    for _ in range(0, index):
        keyboard.press(Key.down)
        keyboard.release(Key.down)

    keyboard.press(Key.enter)
    keyboard.release(Key.enter)
    time.sleep(WAIT_SHORT)


def logger(index):
    with open(LOG_FILE, "a") as file:
        file.write(f"{time.asctime()}, {index}. resim paylaşıldı.\n")


""" 
def update_config(index=0):
    with open(CONFIG_FILE, "w") as file:
        file.write(f"START_INDEX={index}\n")
        file.write(
            f"FINISH_INDEX={FINISH_INDEX if ('FINISH_INDEX' in globals()) else 0}\n")
 """


def share_post(index=0):
    mouse.position = POSITION_NEXT
    mouse.click(Button.left, count=1)
    time.sleep(WAIT_SHORT)
    mouse.click(Button.left, count=1)
    logger(index)
    # update_config(index)
    time.sleep(WAIT_LONG)


def start(function, param=None):
    if param is None:
        function()
    else:
        function(param)
    time.sleep(WAIT_SHORT)


"""
def load_config():

    def remove_comments(line):
        index = line.find("#")
        if index == -1:
            return line.strip()
        else:
            return line[:line.find("#")]

    def parse_value(line):
        try:
            return line.split("=")[1].strip()
        except:
            return ''

    def read_config():
        global START_INDEX, CONFIG_FILE, FINISH_INDEX
        with open(CONFIG_FILE, "r") as file:
            for line in file:
                line = remove_comments(line)
                if "START_INDEX" in line:
                    START_INDEX = int(parse_value(line))
                if "FINISH_INDEX" in line:
                    FINISH_INDEX = int(parse_value(line))

    try:
        read_config()
    except:
        update_config()
    finally:
        read_config()
"""


def is_finished():
    global START_INDEX, FINISH_INDEX
    return START_INDEX >= FINISH_INDEX


def main():
    configure_positions()
    # load_config()

    if is_finished():
        print(
            f"Başlangıç ile bitiş indeksleri aynı, dosya indekslerini tekrar giriniz")
        exit()

    global FINISH_INDEX
    for i in range(START_INDEX, FINISH_INDEX):
        start(touch_plus_button)
        start(select_file, i)
        start(share_post, i+1)


if __name__ == "__main__":
    main()
