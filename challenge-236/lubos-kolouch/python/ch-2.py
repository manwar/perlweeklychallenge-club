#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Python implementation for "Array Loops" problem
from typing import List


def find_loops(arr: List[int]) -> int:
    visited = set()
    loop_count = 0

    for i in range(len(arr)):
        # Skip if this index has been visited
        if i in visited:
            continue

        # Initialize a new loop
        loop_count += 1
        current_index = i

        # Find members of this loop
        while current_index not in visited:
            visited.add(current_index)
            current_index = arr[current_index]

    return loop_count


# Test cases
test_cases = [
    ([4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10], 3),
    ([0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19], 6),
    ([9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17], 1),
]

for i, (arr, expected) in enumerate(test_cases):
    result = find_loops(arr)
    print(
        f"Test case {i+1}: {'Passed' if result == expected else 'Failed'} (Got: {result}, Expected: {expected})"
    )
