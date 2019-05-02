"""Instagramda Otomatik Foto Paylaşma
"""

from pynput.mouse import Button as Button, Controller as MController
from pynput.keyboard import Key, Controller as KController
import time


FILE_COUNT = 130

POSITION = (359, 715)
FILE_POSITION = (201, 121)
POSITION_NEXT = (489, 188)
WAIT_LONG = 7
WAIT_SHORT = 1

CONFIG_FILE = "poster.cfg"

mouse = MController()
keyboard = KController()


def touch_plus_button():
    mouse.position = POSITION
    mouse.click(Button.left)


def select_file(index):
    for _ in range(0, index):
        keyboard.press(Key.down)
        keyboard.release(Key.down)

    keyboard.press(Key.enter)
    keyboard.release(Key.enter)


def update_config(index=0):
    with open(CONFIG_FILE, "w") as file:
        file.write(f"START_INDEX={index}")


def share_post():
    mouse.position = POSITION_NEXT
    mouse.click(Button.left, count=1)
    time.sleep(WAIT_SHORT)
    mouse.click(Button.left, count=1)


def start(function, param=None):
    if param is None:
        function()
    else:
        function(param)
    time.sleep(WAIT_SHORT)


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
        global START_INDEX, CONFIG_FILE
        with open(CONFIG_FILE, "r") as file:
            for line in file:
                line = remove_comments(line)
                if "START_INDEX" in line:
                    START_INDEX = int(parse_value(line))

    try:
        read_config()
    except:
        update_config()
    finally:
        read_config()


def main():
    load_config()
    for i in range(START_INDEX, FILE_COUNT):
        start(touch_plus_button)
        start(select_file, param=i)
        start(share_post)
        update_config(index=i)
        time.sleep(WAIT_LONG)


if __name__ == "__main__":
    main()
