#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List
from collections import Counter


def frequency_sort_python(ints: List[int]) -> List[int]:
    """
    Sort the integers in increasing order based on frequency. If multiple values 
    have the same frequency then sort them in decreasing order.

    Parameters:
    - ints (List[int]): List of integers to be sorted.

    Returns:
    - List[int]: List of integers sorted based on frequency.
    """

    # Count frequencies
    frequency = Counter(ints)

    # Custom sort
    sorted_ints = sorted(ints, key=lambda x: (frequency[x], -x))

    return sorted_ints


# Testing the Python solution
test_cases = [
    ([1, 1, 2, 2, 2, 3], [3, 1, 1, 2, 2, 2]),
    ([2, 3, 1, 3, 2], [1, 3, 3, 2, 2]),
    ([-1, 1, -6, 4, 5, -6, 1, 4, 1], [5, -1, 4, 4, -6, -6, 1, 1, 1])
]

results_python = [(test, frequency_sort_python(test))
                  for test, expected in test_cases]
print(results_python)
