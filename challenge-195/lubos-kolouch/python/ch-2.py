#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import Counter


def most_frequent_even(numbers):
    even_frequency = Counter(num for num in numbers if num % 2 == 0)

    if not even_frequency:
        return -1

    max_freq = max(even_frequency.values())
    candidates = [num for num, freq in even_frequency.items()
                  if freq == max_freq]

    return min(candidates)


# Test Cases
assert most_frequent_even([1, 1, 2, 6, 2]) == 2, 'Most frequent even number'
assert most_frequent_even([1, 3, 5, 7]) == -1, 'No even number'
assert most_frequent_even(
    [6, 4, 4, 6, 1]) == 4, 'Multiple most frequent even numbers'

print("All tests passed!")
