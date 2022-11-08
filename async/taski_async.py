import asyncio
import random


async def two(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def one(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def main():
    for x in range(5):
        task1 = asyncio.create_task(one(1))
        task2 = asyncio.create_task(two(2))
        await task1
        await task2


asyncio.run(main())