#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_matching_members(ints):
    original = list(ints)
    sorted_ints = sorted(ints)

    return sum(o == s for o, s in zip(original, sorted_ints))


print(count_matching_members([1, 1, 4, 2, 1, 3]))
print(count_matching_members([5, 1, 2, 3, 4]))
print(count_matching_members([1, 2, 3, 4, 5]))
