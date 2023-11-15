#!/usr/bin/python3
from math import floor
def floor_sum(*nums: int) -> int:
    return sum([floor(i / j) for i in nums for j in nums])

assert floor_sum(2, 5, 9) == 10
assert floor_sum(7, 7, 7, 7, 7, 7, 7) == 49
