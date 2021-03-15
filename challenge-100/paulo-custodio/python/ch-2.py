#!/usr/bin/env python

# Challenge 100
# 
# TASK #2 > Triangle Sum
# Submitted by: Mohammad S Anwar
# You are given triangle array.
#
# Write a script to find the minimum path sum from top to bottom.
#
# When you are on index i on the current row then you may move to either
# index i or index i + 1 on the next row.
#
# Example 1:
# Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
# Output: 8
#
# Explanation: The given triangle
#
#             1
#            2 4
#           6 4 9
#          5 1 7 2
#
# The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
#
#              [1]
#            [2]  4
#            6 [4] 9
#           5 [1] 7 2
# Example 2:
# Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
# Output: 7
#
# Explanation: The given triangle
#
#             3
#            3 1
#           5 2 3
#          4 3 1 3
#
# The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
#
#              [3]
#             3  [1]
#            5 [2] 3
#           4 3 [1] 3

import sys;

triangle = []

def add_row(row, items):
    triangle.append(items)

def parse(args):
    for i in range(0, len(args)):
        items = [int(x) for x in args[i].split(",")]
        add_row(i, items)

def min_sum():
    def min_sum_1(sum, row, col):
        sum += triangle[row][col]
        if row+1 == len(triangle):
            return sum
        else:
            sum1 = min_sum_1(sum, row+1, col)
            sum2 = min_sum_1(sum, row+1, col+1)
            return min(sum1, sum2)
    return min_sum_1(0, 0, 0)

parse(sys.argv[1:])
print(min_sum())



