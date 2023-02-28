#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def max_min_pair_sum(array: List[int]) -> int:
    # Sort the array in ascending order
    sorted_array = sorted(array)

    # Use pairwise iterator to get pairs of adjacent elements
    # (0,1), (2,3), (4,5), ...
    pairwise_array = [(sorted_array[i], sorted_array[i + 1])
                      for i in range(0, len(sorted_array), 2)]

    # Calculate the sum of the minimum of each pair
    return sum(min(pair) for pair in pairwise_array)


# Define test cases
test1 = [1, 2, 3, 4]
expected1 = 4
test2 = [0, 2, 1, 3]
expected2 = 2

# Run tests
assert max_min_pair_sum(test1) == expected1
assert max_min_pair_sum(test2) == expected2
