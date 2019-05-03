from pynput.mouse import Button, Controller
import time

# Yapılandırma sabitleri
START_POSITION = (1413, 293)
FIRST_MOVE = (80, 248)
LAST_MOVE = (-600, 22)
WAIT_TIME = 1


# Fare kontrolcüsünü oluşturma
mouse = Controller()

mouse.position = START_POSITION
time.sleep(WAIT_TIME)

mouse.click(Button.right, 1)
time.sleep(WAIT_TIME)

mouse.move(FIRST_MOVE[0], FIRST_MOVE[1])
mouse.click(Button.left, 1)
time.sleep(WAIT_TIME)

mouse.move(LAST_MOVE[0], LAST_MOVE[1])
mouse.click(Button.left, 1)
