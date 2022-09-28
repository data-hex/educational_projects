import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import math


@pytest.fixture(scope="function")
def browser():
    print("\nstart browser for test..")
    browser = webdriver.Chrome()
    yield browser
    print("\nquit browser..")
    browser.quit()
    print(''.join(result))


spisok = ["https://stepik.org/lesson/236895/step/1",
          "https://stepik.org/lesson/236896/step/1",
          "https://stepik.org/lesson/236897/step/1",
          "https://stepik.org/lesson/236898/step/1",
          "https://stepik.org/lesson/236899/step/1",
          "https://stepik.org/lesson/236903/step/1",
          "https://stepik.org/lesson/236904/step/1",
          "https://stepik.org/lesson/236905/step/1"]

result = []


@pytest.mark.parametrize('url', spisok)
def test_link(browser, url):
    link = f"{url}"
    browser.get(link)
    browser.implicitly_wait(10)

    answerField = WebDriverWait(browser, 10).until(
        EC.visibility_of_element_located((By.TAG_NAME, 'textarea'))
    )
    answer = str(math.log(int(time.time())))
    answerField.send_keys(answer)
    btn = WebDriverWait(browser, 10).until(
        EC.visibility_of_element_located((By.CSS_SELECTOR, '[class="submit-submission"]'))
    )
    btn.click()
    message = WebDriverWait(browser, 10) \
        .until(EC.visibility_of_element_located((By.CSS_SELECTOR, '[class="smart-hints__hint"]'))).text
    try:
        assert message == 'Correct!', f'Error: {message}'
    except AssertionError:
        result.append(message)
        raise AssertionError




