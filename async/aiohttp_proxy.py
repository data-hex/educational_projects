import aiohttp
import asyncio

url = 'http://httpbin.org/ip'

async def main():
    proxy = 'http://127.0.0.1:80'
    async with aiohttp.ClientSession() as session:
        proxy_auth = aiohttp.BasicAuth('user', 'pass')
        async with session.get(url=url, proxy=proxy, proxy_auth=proxy_auth) as response:
            print(await response.text())

asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
asyncio.run(main())