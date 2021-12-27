#!/usr/bin/python3

# Challenge 026
#
# Task #2
# Create a script that prints mean angles of the given list of angles in degrees.
# Please read wiki page that explains the formula in details with an example.

import sys
import math

def mean(a):
    # convert to radians
    a = list(map(math.radians, a))

    # compute sum of sin and cos
    x = sum(map(math.cos, a))
    y = sum(map(math.sin, a))

    # compute mean
    a = math.atan2(y, x)

    # convert back to degrees
    a = math.degrees(a)

    return a

print("{:.1f}".format(mean([int(x) for x in sys.argv[1:]])))
