import asyncio
import random


async def one(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def two(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def three(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def main():
    group1 = asyncio.gather(*[one(i) for i in range(1, 10)])
    group2 = asyncio.gather(*[two(i) for i in range(1, 10)])
    group3 = asyncio.gather(*[three(i) for i in range(1, 10)])

    await asyncio.gather(group1, group2, group3)


asyncio.run(main())