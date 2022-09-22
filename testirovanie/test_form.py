#task https://stepik.org/lesson/36285/step/13?unit=162401

import unittest
import time

from selenium import webdriver
from selenium.webdriver.common.by import By


class TestAbs(unittest.TestCase):
    def test_form1(self):
        link = "http://suninjuly.github.io/registration1.html"
        browser = webdriver.Chrome()
        browser.get(link)

        # Ваш код, который заполняет обязательные поля
        input_name = browser.find_element(By.CSS_SELECTOR, ".first_block .first")
        input_name.send_keys("Ivan")

        time.sleep(0.5)

        input_lastname = browser.find_element(By.CSS_SELECTOR, ".first_block .second")
        input_lastname.send_keys("Ivanov")

        time.sleep(0.5)

        input_email = browser.find_element(By.CSS_SELECTOR, ".first_block .third")
        input_email.send_keys("Ivanov@mail.ru")

        time.sleep(0.5)

        # Отправляем заполненную форму
        button = browser.find_element(By.CSS_SELECTOR, "button.btn")
        button.click()

        # Проверяем, что смогли зарегистрироваться
        # ждем загрузки страницы
        time.sleep(1)

        # находим элемент, содержащий текст
        welcome_text_elt = browser.find_element(By.TAG_NAME, "h1")
        # записываем в переменную welcome_text текст из элемента welcome_text_elt
        welcome_text = welcome_text_elt.text


        # с помощью assert проверяем, что ожидаемый текст совпадает с текстом на странице сайта
        self.assertEqual("Congratulations! You have successfully registered!", welcome_text, f"Text must match")

    def test_form2(self):
        link = "http://suninjuly.github.io/registration2.html"
        browser = webdriver.Chrome()
        browser.get(link)

        # Ваш код, который заполняет обязательные поля
        input_name = browser.find_element(By.CSS_SELECTOR, ".first_block .first")
        input_name.send_keys("Ivan")

        time.sleep(0.5)

        input_lastname = browser.find_element(By.CSS_SELECTOR, ".first_block .second")
        input_lastname.send_keys("Ivanov")

        time.sleep(0.5)

        input_email = browser.find_element(By.CSS_SELECTOR, ".first_block .third")
        input_email.send_keys("Ivanov@mail.ru")

        time.sleep(0.5)

        # Отправляем заполненную форму
        button = browser.find_element(By.CSS_SELECTOR, "button.btn")
        button.click()

        # Проверяем, что смогли зарегистрироваться
        # ждем загрузки страницы
        time.sleep(1)

        # находим элемент, содержащий текст
        welcome_text_elt = browser.find_element(By.TAG_NAME, "h1")
        # записываем в переменную welcome_text текст из элемента welcome_text_elt
        welcome_text = welcome_text_elt.text

        # с помощью assert проверяем, что ожидаемый текст совпадает с текстом на странице сайта
        self.assertEqual("Congratulations! You have successfully registered!", welcome_text, f"Text must match")


if __name__ == "__main__":
    unittest.main()