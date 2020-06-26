import time
from threading import Thread

import keyboard
import mouse


def event_loop():
    while True:
        if runnable_space:
            keyboard.press_and_release("space")
        if runnable_click:
            mouse.click()
        if exit_condition:
            break
        time.sleep(1)


def reverse_runnable_space():
    global runnable_space
    runnable_space = not runnable_space


def reverse_runnable_click():
    global runnable_click
    runnable_click = not runnable_click


exit_condition = False
runnable_space = False
runnable_click = False
Thread(target=event_loop).start()
keyboard.add_hotkey("win+shift+u", reverse_runnable_space)
keyboard.add_hotkey("win+shift+c", reverse_runnable_click)
keyboard.wait("win+esc", suppress=True)
exit_condition = True
