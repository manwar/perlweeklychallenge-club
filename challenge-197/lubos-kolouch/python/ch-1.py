#!/usr/bin/env python
# -*- coding: utf-8 -*-

def move_zeros(lst):
    non_zeros = [x for x in lst if x != 0]
    zeros_count = len(lst) - len(non_zeros)
    return non_zeros + [0] * zeros_count


# Test cases
assert move_zeros([1, 0, 3, 0, 0, 5]) == [1, 3, 5, 0, 0, 0], "Example 1"
assert move_zeros([1, 6, 4]) == [1, 6, 4], "Example 2"
assert move_zeros([0, 1, 0, 2, 0]) == [1, 2, 0, 0, 0], "Example 3"

print("All tests passed!")
