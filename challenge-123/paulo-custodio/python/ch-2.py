#!/usr/bin/env python3

# TASK #2 > Square Points
# Submitted by: Mohammad S Anwar
# You are given coordinates of four points i.e.
# (x1, y1), (x2, y2), (x3, y3) and (x4, y4).
#
# Write a script to find out if the given four points form a square.
#
# Example
# Input: x1 = 10, y1 = 20
#        x2 = 20, y2 = 20
#        x3 = 20, y3 = 10
#        x4 = 10, y4 = 10
# Output: 1 as the given coordinates form a square.
#
# Input: x1 = 12, y1 = 24
#        x2 = 16, y2 = 10
#        x3 = 20, y3 = 12
#        x4 = 18, y4 = 16
# Output: 0 as the given coordinates doesn't form a square.

import sys

class Point():
    def __init__(self, x, y):
        self.x = x
        self.y = y

# square of distance between two points
def dist_sq(p, q):
    return (p.x - q.x) * (p.x - q.x) + \
           (p.y - q.y) * (p.y - q.y)

# check if four points form a square
def is_square(p1, p2, p3, p4):
    d2 = dist_sq(p1, p2)
    d3 = dist_sq(p1, p3)
    d4 = dist_sq(p1, p4)

    if d2 == 0 or d3 == 0 or d4 == 0:
        return False
    elif d2 == d3 and 2 * d2 == d4 and 2 * dist_sq(p2, p4) == dist_sq(p2, p3):
        return True
    elif d3 == d4 and 2 * d3 == d2 and 2 * dist_sq(p3, p2) == dist_sq(p3, p4):
        return True
    elif d2 == d4 and 2 * d2 == d3 and 2 * dist_sq(p2, p3) == dist_sq(p2, p4):
        return True
    else:
        return False

p1 = Point(int(sys.argv[1]), int(sys.argv[2]))
p2 = Point(int(sys.argv[3]), int(sys.argv[4]))
p3 = Point(int(sys.argv[5]), int(sys.argv[6]))
p4 = Point(int(sys.argv[7]), int(sys.argv[8]))

if is_square(p1, p2, p3, p4):
    print(1)
else:
    print(0)
