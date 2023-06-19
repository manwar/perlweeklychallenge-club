#!/usr/bin/env python
# -*- coding: utf-8 -*-


def longest_arithmetic_subsequence(ints):
    dp = {}
    max_length = 2  # minimal length of arithmetic subsequence is 2

    for i in range(1, len(ints)):
        for j in range(i):
            diff = ints[i] - ints[j]
            dp[i, diff] = dp.get((j, diff), 1) + 1
            max_length = max(max_length, dp[i, diff])

    return max_length


ints = [9, 4, 7, 2, 10]
print(longest_arithmetic_subsequence(ints))  # Output: 3

ints = [3, 6, 9, 12]
print(longest_arithmetic_subsequence(ints))  # Output: 4

ints = [20, 1, 15, 3, 10, 5, 8]
print(longest_arithmetic_subsequence(ints))  # Output: 4
