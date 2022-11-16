#task https://stepik.org/lesson/742823/step/5?unit=744612
import aiofiles
import asyncio
import aiohttp
from bs4 import BeautifulSoup
import os
import requests

site = "https://parsinger.ru/asyncio/aiofile/2/index.html"
domain = "https://parsinger.ru/asyncio/aiofile/2/"
urls = []


def get_soup(url):
    resp = requests.get(url=url)
    return BeautifulSoup(resp.text, 'lxml')


def get_urls(soup):
    all_link = soup.find_all('a', class_="lnk_img")

    for link in all_link:
        urls.append(domain + link['href'])


async def write_file(session, url, name_img):
    async with aiofiles.open(f'images/{name_img}', mode='wb') as f:
        async with session.get(url) as response:
            async for x in response.content.iter_chunked(1024):
                await f.write(x)
        print(f'Изображение сохранено {name_img}')


async def main():
    global urls
    for url in urls:
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                soup2 = BeautifulSoup(await response.text(), 'lxml')
                img_url = [f'{x["src"]}' for x in soup2.find_all('img')]
                tasks = []
                for link in img_url:
                    name_img = link.split('/')[6]
                    task = asyncio.create_task(write_file(session, link, name_img))
                    tasks.append(task)
                await asyncio.gather(*tasks)


soup = get_soup(site)
get_urls(soup)

asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
asyncio.run(main())


def get_folder_size(filepath, size=0):
    for root, dirs, files in os.walk(filepath):
        for f in files:
            size += os.path.getsize(os.path.join(root, f))
    return size


print(get_folder_size('images/'))
