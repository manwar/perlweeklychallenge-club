#!/usr/bin/env python
# -*- coding: utf-8 -*-


def trailing_zeros(n: int) -> int:
    count = 0
    i = 5
    while n // i >= 1:
        count += n // i
        i *= 5
    return count


# Test cases:
print(trailing_zeros(10))  # Output: 2
print(trailing_zeros(7))  # Output: 1
print(trailing_zeros(4))  # Output: 0
