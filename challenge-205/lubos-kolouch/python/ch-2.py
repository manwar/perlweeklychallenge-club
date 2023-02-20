#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def find_max_xor(array: List[int]) -> int:
    """
    Finds the highest value obtained by XORing any two distinct members of an array of integers.

    Args:
        array: List of integers to search.

    Returns:
        The highest value obtained by XORing any two distinct members of the input array.
    """
    max_xor = 0
    for i in range(len(array)):
        for j in range(i + 1, len(array)):
            xor = array[i] ^ array[j]
            if xor > max_xor:
                max_xor = xor
    return max_xor


# Test cases
def test_find_max_xor():
    assert find_max_xor([1, 2, 3, 4, 5, 6, 7]) == 7
    assert find_max_xor([2, 4, 1, 3]) == 7
    assert find_max_xor([10, 5, 7, 12, 8]) == 15
    assert find_max_xor([2, 2, 2, 2]) == 0


test_find_max_xor()
