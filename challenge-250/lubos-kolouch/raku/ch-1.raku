#!/usr/bin/env python
# -*- coding: utf-8 -*-

import typing


# Define a function to find the smallest index i such that i mod 10 == ints[i] using list comprehension
def smallest_index(ints: typing.List[int]) -> int:
    # Create a list of indices that satisfy the condition using list comprehension
    indices = [i for i in range(len(ints)) if i % 10 == ints[i]]
    # Return the smallest index if the list is not empty, otherwise return -1
    return min(indices) if indices else -1


# Test the function with some examples
print(smallest_index([0, 1, 2]))  # Output: 0
print(smallest_index([4, 3, 2, 1]))  # Output: 2
print(smallest_index([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]))  # Output: -1
