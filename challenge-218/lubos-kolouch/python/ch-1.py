#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def max_triplet_product(nums: List[int]) -> int:
    nums.sort()
    return max(nums[-1] * nums[-2] * nums[-3], nums[0] * nums[1] * nums[-1])


# Test cases:
print(max_triplet_product([3, 1, 2]))  # Output: 6
print(max_triplet_product([4, 1, 3, 2]))  # Output: 24
print(max_triplet_product([-1, 0, 1, 3, 1]))  # Output: 3
print(max_triplet_product([-8, 2, -9, 0, -4, 3]))  # Output: 216
