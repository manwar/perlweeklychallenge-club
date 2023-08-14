#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def find_pattern_132(nums: List[int]) -> List[int]:

    for i in range(len(nums)):

        for j in range(i+1, len(nums)):

            for k in range(j+1, len(nums)):

                if nums[i] < nums[k] < nums[j]:

                    return [nums[i], nums[j], nums[k]]

    return []


# Test cases
print(find_pattern_132([3, 1, 4, 2]))  # Expected: [1, 4, 2]

print(find_pattern_132([1, 2, 3, 4]))  # Expected: []

print(find_pattern_132([1, 3, 2, 4, 6, 5]))  # Expected: [1, 3, 2]

print(find_pattern_132([1, 3, 4, 2]))  # Expected: [1, 3, 2]
