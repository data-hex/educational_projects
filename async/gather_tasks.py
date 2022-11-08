import asyncio
import random


async def one(x):
    await asyncio.sleep(random.randint(1, 3))
    return print(x)


async def main():
    lst = [x for x in range(10)]
    lst_tasks = []
    for x in lst:
        task = asyncio.create_task(one(x))
        lst_tasks.append(task)
    await asyncio.gather(*lst_tasks)


asyncio.run(main())