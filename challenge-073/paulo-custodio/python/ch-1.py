#!/usr/bin/env python3

# Challenge 073
#
# TASK #1 > Min Sliding Window
# Submitted by: Mohammad S Anwar
# You are given an array of integers @A and sliding window size $S.
#
# Write a script to create an array of min from each sliding window.
#
# Example
# Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
# Output: (0, 0, 0, 2, 3, 3, 4, 4)
#
# [(1 5 0) 2 9 3 7 6 4 8] = Min (0)
# [1 (5 0 2) 9 3 7 6 4 8] = Min (0)
# [1 5 (0 2 9) 3 7 6 4 8] = Min (0)
# [1 5 0 (2 9 3) 7 6 4 8] = Min (2)
# [1 5 0 2 (9 3 7) 6 4 8] = Min (3)
# [1 5 0 2 9 (3 7 6) 4 8] = Min (3)
# [1 5 0 2 9 3 (7 6 4) 8] = Min (4)
# [1 5 0 2 9 3 7 (6 4 8)] = Min (4)

import sys

def min_sliding_window(s, a):
    min_ = []
    for i in range(0, len(a)-s+1):
        sub_ = a[i:i+s]
        min_.append(min(sub_))
    return min_

S = int(sys.argv[1])
M = list(map(int, sys.argv[2:]))
min_ = min_sliding_window(S, M)
print(", ".join([str(x) for x in min_]))
