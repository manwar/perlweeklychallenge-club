#!/usr/bin/env python3
#
#
#       one-two-up-we-go.py
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



from functools import lru_cache

@lru_cache(maxsize = 1000)
def fib(n):
    if n < 0:
        return None
    if n < 2:
        return n
    else:
        return fib(n-1) + fib(n-2)


for i in range(2, 21):
    ways = fib(i+1)
    print(f"for {i} steps there are {ways} ways to climb them")
