#!/usr/bin/env python
# -*- coding: utf-8 -*-


def largest_multiple(arr):
    arr = sorted([str(x) for x in arr if x % 2 == 0], key=lambda x: x * 3, reverse=True)
    return int("".join(arr))


# Test
print(largest_multiple([1, 0, 2, 6, 9, 4, 5]))  # Output: 6420
