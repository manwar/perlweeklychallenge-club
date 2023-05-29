#!/usr/bin/env python
# -*- coding: utf-8 -*-

def sorted_squares(nums):
    return sorted(x**2 for x in nums)


# Test
print(sorted_squares([-2, -1, 0, 3, 4]))  # Output: [0, 1, 4, 9, 16]
print(sorted_squares([5, -4, -1, 3, 6]))  # Output: [1, 9, 16, 25, 36]
