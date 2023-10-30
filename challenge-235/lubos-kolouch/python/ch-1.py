#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_increasing(arr: List[int]) -> bool:
    """
    Check if a list is strictly increasing.
    """
    for i in range(1, len(arr)):
        if arr[i] <= arr[i-1]:
            return False
    return True


def can_be_made_increasing(ints: List[int]) -> bool:
    """
    Check if removing one element can make the list strictly increasing.
    """
    for i in range(len(ints)):
        new_list = ints[:i] + ints[i+1:]
        if is_increasing(new_list):
            return True
    return False


# Test the Python solution
print(can_be_made_increasing([0, 2, 9, 4, 6]))  # Expected Output: True
print(can_be_made_increasing([5, 1, 3, 2]))    # Expected Output: False
print(can_be_made_increasing([2, 2, 3]))       # Expected Output: True
