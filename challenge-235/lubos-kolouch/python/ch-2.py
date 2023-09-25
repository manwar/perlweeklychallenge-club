#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def duplicate_zeros(ints: List[int]) -> List[int]:
    """
    Duplicate each occurrence of ZERO in the given array and shift the remaining to the right,
    ensuring the size of the array remains the same.
    """
    zeros = ints.count(0)

    i = len(ints) - 1
    while zeros > 0:
        if i + zeros < len(ints):
            ints[i + zeros] = ints[i]
        if ints[i] == 0:
            zeros -= 1
            if i + zeros < len(ints):
                ints[i + zeros] = 0
        i -= 1

    return ints


# Test cases
# Expected: [1, 0, 0, 2, 3, 0, 0, 4]
print(duplicate_zeros([1, 0, 2, 3, 0, 4, 5, 0]))
print(duplicate_zeros([1, 2, 3]))  # Expected: [1, 2, 3]
print(duplicate_zeros([0, 3, 0, 4, 5]))  # Expected: [0, 0, 3, 0, 0]
