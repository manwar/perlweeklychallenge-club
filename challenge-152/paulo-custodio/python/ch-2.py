#!/usr/bin/env python3

# Challenge 152
#
# TASK #2 > Rectangle Area
# Submitted by: Mohammad S Anwar
# You are given coordinates bottom-left and top-right corner of two rectangles
# in a 2D plane.
#
# Write a script to find the total area covered by the two rectangles.
#
# Example 1:
# Input: Rectangle 1 => (-1,0), (2,2)
#        Rectangle 2 => (0,-1), (4,4)
#
# Output: 22
# Example 2:
# Input: Rectangle 1 => (-3,-1), (1,3)
#        Rectangle 2 => (-1,-3), (2,2)
#
# Output: 25

import sys

x1, y1, x2, y2, x3, y3, x4, y4 = map(int, sys.argv[1:])

# area of rectangles
area12 = abs(x2-x1)*abs(y2-y1)
area34 = abs(x4-x3)*abs(y4-y3)

# intersection of rectangles
x5 = max(x1, x3)
y5 = max(y1, y3)
x6 = min(x2, x4)
y6 = min(y2, y4)

area56 = abs(x6-x5)*abs(y6-y5)

if x5 > x6 or y5 > y6:   # no intersection
    area56 = 0

area = area12 + area34 - area56

print(area)
