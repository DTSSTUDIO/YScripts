import time

import mouse


def close_app():
    global can_work
    can_work = False

can_work = True
while can_work:
    mouse.click(button=mouse.LEFT)
    mouse.on_right_click(close_app)
    time.sleep(0.5)
