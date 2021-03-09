#! /usr/bin/env python

# Challenge 101
#
# TASK #2 > Origin-containing Triangle
# Submitted by: Stuart Little
# You are given three points in the plane, as a list of six co-ordinates:
# A=(x1,y1), B=(x2,y2) and C=(x3,y3).
#
# Write a script to find out if the triangle formed by the given three
# co-ordinates contain origin (0,0).
#
# Print 1 if found otherwise 0.

import sys

def point_in_triangle(xp,yp, x1,y1,x2,y2,x3,y3):
    def sign(x1,y1,x2,y2,x3,y3):
        return (x1 - x3) * (y2 - y3) - (x2 - x3) * (y1 - y3)

    d1 = sign(xp,yp, x1,y1, x2,y2)
    d2 = sign(xp,yp, x2,y2, x3,y3)
    d3 = sign(xp,yp, x3,y3, x1,y1)

    has_neg = (d1 < 0) or (d2 < 0) or (d3 < 0)
    has_pos = (d1 > 0) or (d2 > 0) or (d3 > 0)

    if (not (has_neg and has_pos)):
        return 1
    else:
        return 0

x1,y1,x2,y2,x3,y3 = (float(sys.argv[i]) for i in range(1, 7))
print(point_in_triangle(0.0,0.0, x1,y1,x2,y2,x3,y3))
