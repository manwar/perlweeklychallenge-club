#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_monotonic(nums: List[int]) -> bool:
    increasing = True
    decreasing = True

    for i in range(len(nums) - 1):
        if nums[i] > nums[i + 1]:
            increasing = False
        if nums[i] < nums[i + 1]:
            decreasing = False

    return increasing or decreasing


# Test cases
test_cases = [
    [1, 2, 3, 4, 5],
    [5, 4, 3, 2, 1],
    [1, 1, 2, 2, 3],
    [1, 2, 3, 2, 1],
    [5, 3, 2, 4, 3],
]

for test_case in test_cases:
    result = is_monotonic(test_case)
    output = 1 if result else 0
    print(f"Array {test_case} is monotonic: {output}")
