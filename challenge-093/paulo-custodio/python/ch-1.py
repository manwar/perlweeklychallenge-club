#!/usr/bin/env python

# Challenge 093
#
# TASK #1 > Max Points
# Submitted by: Mohammad S Anwar
# You are given set of co-ordinates @N.
#
# Write a script to count maximum points on a straight line when given co-ordinates plotted on 2-d plane.
#
# Example 1:
# |
# |     x
# |   x
# | x
# + _ _ _ _
#
# Input: (1,1), (2,2), (3,3)
# Output: 3
# Example 2:
# |
# |
# | x       x
# |   x
# | x   x
# + _ _ _ _ _
#
# Input: (1,1), (2,2), (3,1), (1,3), (5,3)
# Output: 3

from __future__ import print_function
import sys

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

class Point:
    """hold a point in 2D space"""
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return "Point({},{})".format(self.x, self.y)

def get_points():
    """get points from sys.argv"""
    if len(sys.argv) < 7 or (len(sys.argv) % 2) == 0:
        eprint("Usage: ch-1.py x y x y x y ...")
        sys.exit(1)

    P = []
    for i in range(1, len(sys.argv)-1, 2):
        P.append(Point(int(sys.argv[i]), int(sys.argv[i+1])))
    return P

def in_line(pi, pj, pk):
    """return true if the three points are in a line"""
    # compute cross product
    dxc = pk.x - pi.x;
    dyc = pk.y - pi.y;

    dxl = pj.x - pi.x;
    dyl = pj.y - pi.y;

    cross = dxc * dyl - dyc * dxl;

    return True if cross == 0 else False

def max_in_line(P):
    """count max number of points in a line"""
    max_count = 0
    # for each pair
    for i in range(0, len(P)-1):
        for j in range(i+1, len(P)):
            # check other points against pair
            count = 0
            for k in range(0, len(P)):
                if in_line(P[i], P[j], P[k]):
                    count += 1
            max_count = max(max_count, count)
    return max_count

def solve():
    P = get_points()
    print(max_in_line(P))

solve()
