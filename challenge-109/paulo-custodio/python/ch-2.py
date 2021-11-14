#!/usr/bin/env python3

# Challenge 109
#
# TASK #2 - Four Squares Puzzle
# Submitted by: Mohammad S Anwar
# You are given four squares as below with numbers named a,b,c,d,e,f,g.
#
#               (1)                    (3)
#         +--------------+      +--------------+
#         |              |      |              |
#         |      a       |      |      e       |
#         |              | (2)  |              |  (4)
#         |          +---+------+---+      +---+---------+
#         |          |   |      |   |      |   |         |
#         |          | b |      | d |      | f |         |
#         |          |   |      |   |      |   |         |
#         |          |   |      |   |      |   |         |
#         +----------+---+      +---+------+---+         |
#                    |       c      |      |      g      |
#                    |              |      |             |
#                    |              |      |             |
#                    +--------------+      +-------------+
# Write a script to place the given unique numbers in the square box so that sum
# of numbers in each box is the same.
#
# Example
# Input: 1,2,3,4,5,6,7
#
# Output:
#
#     a = 6
#     b = 4
#     c = 1
#     d = 5
#     e = 2
#     f = 3
#     g = 7
#
#     Box 1: a + b = 6 + 4 = 10
#     Box 2: b + c + d = 4 + 1 + 5 = 10
#     Box 3: d + e + f = 5 + 2 + 3 = 10
#     Box 4: f + g = 3 + 7 = 10

import sys
from itertools import permutations

# Note: return first solution found, not necessarily same as example
def place_numbers(nums):
    for p in permutations(nums, 7):
        a,b,c,d,e,f,g = p[0],p[1],p[2],p[3],p[4],p[5],p[6]
        sum = a+b
        if b + c + d == sum and d + e + f == sum and f + g == sum:
            return p

result = place_numbers([int(x) for x in sys.argv[1:]])
for i in range(7):
    print(chr(ord('a')+i)+" = "+str(result[i]))
