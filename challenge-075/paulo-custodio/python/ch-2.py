#!/usr/bin/env python3

# Challenge 075
#
# TASK #2 > Largest Rectangle Histogram
# Submitted by: Mohammad S Anwar
# You are given an array of positive numbers @A.
#
# Write a script to find the largest rectangle histogram created by the given
# array.
#
# BONUS: Try to print the histogram as shown in the example, if possible.
#
# Example 1:
#
# Input: @A = (2, 1, 4, 5, 3, 7)
#      7           #
#      6           #
#      5       #   #
#      4     # #   #
#      3     # # # #
#      2 #   # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        2 1 4 5 3 7
# Looking at the above histogram, the largest rectangle (4 x 3) is formed by
# columns (4, 5, 3 and 7).
#
# Output: 12
#
# Example 2:
#
# Input: @A = (3, 2, 3, 5, 7, 5)
#      7         #
#      6         #
#      5       # # #
#      4       # # #
#      3 #   # # # #
#      2 # # # # # #
#      1 # # # # # #
#      _ _ _ _ _ _ _
#        3 2 3 5 7 5
# Looking at the above histogram, the largest rectangle (3 x 5) is formed by
# columns (5, 7 and 5).
#
# Output: 15

import sys

def make_histogram(a):
    max_ = max(a)
    hist = [[0 for c in range(len(a))] for r in range(max_)]
    for c in range(len(a)):
        for r in range(max_-1+1):
            hist[r][c] = False if r >= a[c] else True
    return hist

def calc_max_area(hist):
    max_area = 0
    for r0 in range(len(hist)):
        for c0 in range(len(hist[0])):
            if hist[r0][c0]:
                for height in range(1, len(hist)-r0+1):
                    for width in range(1, len(hist[0])-c0+1):
                        all_ones = True
                        for r in range(r0, r0+height):
                            for c in range (c0, c0+width):
                                if not hist[r][c]:
                                    all_ones = False;
                        if all_ones:
                            max_area = max(max_area, width*height)
    return max_area

n = [int(x) for x in sys.argv[1:]]
hist = make_histogram(n)
max_area = calc_max_area(hist)
print(max_area)
