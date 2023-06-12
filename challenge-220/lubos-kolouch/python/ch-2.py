#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import permutations
import math


def is_squareful(arr):
    return all(math.isqrt(arr[i] + arr[i+1])**2 == arr[i] + arr[i+1] for i in range(len(arr) - 1))


def squareful_permutations(ints):
    return list(set(perm for perm in permutations(ints) if is_squareful(perm)))


# Test Cases
print(squareful_permutations([1, 17, 8]))  # [(1, 8, 17), (17, 8, 1)]
print(squareful_permutations([2, 2, 2]))  # [(2, 2, 2)]
