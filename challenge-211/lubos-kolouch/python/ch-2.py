#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import combinations
from typing import List


def can_split_with_same_average(nums: List[int]) -> bool:
    """
    Check if the given list of integers can be split into two separate lists with the same average.

    :param nums: A list of integers.
    :return: True if the list can be split with the same average, False otherwise.
    """
    total = sum(nums)
    n = len(nums)

    for i in range(1, n):
        for comb in combinations(nums, i):
            sum_comb = sum(comb)
            if sum_comb * (n - i) == (total - sum_comb) * i:
                return True
    return False


# Test cases
nums1 = [1, 2, 3, 4, 5, 6, 7, 8]
nums2 = [1, 3]

# Tests
assert can_split_with_same_average(nums1) == True
assert can_split_with_same_average(nums2) == False

print("All tests passed!")
