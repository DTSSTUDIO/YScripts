import atexit
import os
from time import time

string = ""
first_step_time = 0
step_time = 0
init_time = time()
passing_time = 0

def getTime():
    global passing_time
    passing_time = time() - init_time
    return passing_time

def stepTime():
    global step_time, first_step_time
    if first_step_time == 0:
        first_step_time = step_time 
    step_time = time() - passing_time - init_time
    return step_time

def slow_ratio():
    if first_step_time != 0:
        return 100 * (step_time / first_step_time)

def debug():
    length = len(string)
    kbyte = length / 1024
    mbyte = kbyte / 1024
    gbyte = mbyte / 1024

    os.system('cls')
    print(f"String uzunluğu:\n")
    print(f"- {gbyte} GB")
    print(f"- {mbyte} MB")
    print(f"- {kbyte} KB")
    print(f"- {length} bytes")
    print("\n")
    print(f"Süre bilgileri:\n")
    print(f"- Adım süresi: {stepTime()}s")
    print(f"- Geçen süre: {getTime()}s")
    print("\n")
    print(f"Oran bilgileri:\n")
    print(f"- Yavaşlama oranı: %{slow_ratio()}")

    
def create1k():
    global string
    for i in range(1024):
        string += '*'
    return string

def create1m():
    global string
    x = create1k()
    for i in range(1024):
        string += x
    
    return string

def create1g():
    global string

    x = create1m()
    for i in range(1024):
        string += x
        debug()

    return string

atexit.register(debug)

print("begin")

x = create1g()
for i in range(1024):
    string += x
