#!/usr/bin/env python
# -*- coding: utf-8 -*-


def left_right_sum_diff(ints):
    left = [sum(ints[:i]) for i in range(len(ints))]
    right = [sum(ints[i + 1 :]) for i in range(len(ints))]
    return [abs(l - r) for l, r in zip(left, right)]


# testing
ints = [10, 4, 8, 3]
print(left_right_sum_diff(ints))  # should print [15, 1, 11, 22]

ints = [1]
print(left_right_sum_diff(ints))  # should print [0]

ints = [1, 2, 3, 4, 5]
print(left_right_sum_diff(ints))  # should print [14, 11, 6, 1, 10]
