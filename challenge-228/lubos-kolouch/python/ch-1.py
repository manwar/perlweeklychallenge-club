#!/usr/bin/env python
# -*- coding: utf-8 -*-

def unique_sum(lst):
    counts = {}
    for num in lst:
        if num in counts:
            counts[num] += 1
        else:
            counts[num] = 1

    return sum(num for num, count in counts.items() if count == 1)


print(unique_sum([2, 1, 3, 2]))  # Output: 4
print(unique_sum([1, 1, 1, 1]))  # Output: 0
print(unique_sum([2, 1, 3, 4]))  # Output: 10
