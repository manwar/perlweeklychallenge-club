#!/usr/bin/env pyhton3

# Challenge 281
#
# Task 1: Check Color
# Submitted by: Mohammad Sajid Anwar
#
# You are given coordinates, a string that represents the coordinates of a
# square of the chessboard as shown below:
#
# Write a script to return true if the square is light, and false if the square
# is dark.
#
# Example 1
#
# Input: $coordinates = "d3"
# Output: true
#
# Example 2
#
# Input: $coordinates = "g5"
# Output: false
#
# Example 3
#
# Input: $coordinates = "e6"
# Output: true

import sys

if len(sys.argv) != 2:
    raise ValueError("Usage: {} coordinates".format(sys.argv[0]))

coords = sys.argv[1]
if not (len(coords) == 2 and coords[0] in 'abcdefgh' and coords[1] in '12345678'):
    raise ValueError("Usage: {} coordinates".format(sys.argv[0]))

light = ((ord(coords[0]) - ord('a')) & 1) ^ (int(coords[1]) - 1 & 1)
print("true" if light else "false")
