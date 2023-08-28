#!/usr/bin/env python
# -*- coding: utf-8 -*-


def max_index(lst):
    return lst.index(max(lst))


print(max_index([5, 2, 9, 1, 7, 6]))  # Output: 2
print(max_index([4, 2, 3, 1, 5, 0]))  # Output: 4
