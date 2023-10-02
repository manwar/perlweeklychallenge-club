#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math


def is_pentagonal(num):
    return (math.sqrt(24 * num + 1) + 1) % 6 == 0


def pentagonal_numbers():
    index = 1
    pentagonal_nums = []
    while True:
        pentagonal_num = index * (3 * index - 1) // 2
        pentagonal_nums.append(pentagonal_num)
        for j in range(index - 1, 0, -1):
            if is_pentagonal(pentagonal_num - pentagonal_nums[j - 1]) and is_pentagonal(
                pentagonal_num + pentagonal_nums[j - 1]
            ):
                return pentagonal_nums[j - 1], pentagonal_num
        index += 1


pair = pentagonal_numbers()
print(f"Pair of Pentagon Numbers: {pair[0]}, {pair[1]}")
