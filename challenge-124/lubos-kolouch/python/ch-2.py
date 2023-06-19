#!/usr/bin/env python
# -*- coding: utf-8 -*-

import itertools


def find_min_difference_subsets(input_list):
    n = len(input_list)
    subset_size = n // 2
    min_difference = float("inf")
    subset1 = subset2 = []

    # Generate all subsets of size n/2 or (n+1)/2
    for subset in itertools.combinations(input_list, subset_size):
        current_difference = abs(sum(input_list) - 2 * sum(subset))
        if current_difference < min_difference:
            min_difference = current_difference
            subset1 = subset
            subset2 = [i for i in input_list if i not in subset]

    return subset1, subset2


print(find_min_difference_subsets([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]))
print(find_min_difference_subsets([10, -15, 20, 30, -25, 0, 5, 40, -5]))
