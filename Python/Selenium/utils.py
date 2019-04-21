import sys
import wget
import os

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
from config import *
from jsmin import jsmin


def min_js(file_path):
    with open(file_path) as js_file:
        return jsmin(js_file.read(), quote_chars="'\"`")


def write_array_to_file(output_name, array):
    with open(output_name, "w") as file:
        for element in array:
            file.write(element + "\n")


def get_path(file_path):
    return sys.prefix + file_path


def initiate_driver():
    chrome_path = get_path(CHROME_DRIVER_PATH)
    return webdriver.Chrome(chrome_path)


def hold_driver(driver):
    WebDriverWait(driver, 10).until(ec.presence_of_all_elements_located((By.ID, ID_WAIT_CASE)))


def get_script():
    return min_js(JS_PATH)


def download_urls(urls):
    os.mkdir(DOWNLOAD_DIR)
    for url in urls:
        wget.download(url, out=DOWNLOAD_DIR)


