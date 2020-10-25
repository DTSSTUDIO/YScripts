import time

import keyboard
import mouse

CLICK_FLAG = False
EXIT_FLAG = False

def toggle_click_flag(key):
    global CLICK_FLAG
    CLICK_FLAG = not CLICK_FLAG

def enable_exit_flag(key):
    global EXIT_FLAG
    EXIT_FLAG = True

keyboard.on_press_key("f6", toggle_click_flag, suppress=True)
keyboard.on_press_key("f7", enable_exit_flag, suppress=True)

while True:
    if EXIT_FLAG:
        exit()
    if CLICK_FLAG:
        mouse.click("left")
        time.sleep(0.1)
    else:
        time.sleep(1)
