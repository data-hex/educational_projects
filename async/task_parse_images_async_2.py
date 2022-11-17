#task https://stepik.org/lesson/742823/step/6?unit=744612
import asyncio
import os
import aiofiles
import aiohttp
from bs4 import BeautifulSoup


async def write_file(session, link, name_img):
    async with aiofiles.open(f'images/{name_img}', mode='wb') as f:
        async with session.get(link) as response:
            async for file in response.content.iter_chunked(2048):
                await f.write(file)
        print(f'Изображение сохранено {name_img}')


async def main(url):
    schema = 'https://parsinger.ru/asyncio/aiofile/3/'
    schema2 = 'https://parsinger.ru/asyncio/aiofile/3/depth2/'

    async with aiohttp.ClientSession() as session:
        async with session.get(url) as response:
            soup = BeautifulSoup(await response.text(), 'lxml')
            all_category = [schema + x['href'] for x in soup.find_all('a')]
            all_page = []
            for category in all_category:
                async with session.get(category) as response2:
                    soup2 = BeautifulSoup(await response2.text(), 'lxml')
                    one_page = [schema2 + x['href'] for x in soup2.find_all('a')]
                    all_page.extend(one_page)
            all_url_image = set()
            for x in all_page:
                async with session.get(x) as response3:
                    soup3 = BeautifulSoup(await response3.text(), 'lxml')
                    all_url_image.update([x['src'] for x in soup3.find_all('img')])
            tasks = []
            for link in all_url_image:
                name_img = link.split('/')[6]
                task = asyncio.create_task(write_file(session, link, name_img))
                tasks.append(task)
            await asyncio.gather(*tasks)


asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
url = 'https://parsinger.ru/asyncio/aiofile/3/index.html'
asyncio.run(main(url))


def get_folder_size(filepath, size=0):
    for root, dirs, files in os.walk(filepath):
        for f in files:
            size += os.path.getsize(os.path.join(root, f))
    return size


print(get_folder_size('images/'))
