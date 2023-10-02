#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import combinations
from collections import Counter
from typing import List


def unequal_triplets(ints: List[int]) -> int:
    """
    Returns the number of unequal triplets from the given list of integers.
    """
    # Count the frequency of each number
    freq = Counter(ints)

    count = 0
    # Generate all possible combinations of 3 distinct numbers
    for combo in combinations(freq.keys(), 3):
        # Calculate the number of triplets possible for each combination
        product = 1
        for num in combo:
            product *= freq[num]
        count += product

    return count


# Testing the Python solution
print(unequal_triplets([4, 4, 2, 4, 3]))  # Output: 3
print(unequal_triplets([1, 1, 1, 1, 1]))  # Output: 0
print(unequal_triplets([4, 7, 1, 10, 7, 4, 1, 1]))  # Output: 28
