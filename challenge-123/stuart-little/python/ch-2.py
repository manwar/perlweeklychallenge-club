#!/usr/bin/env python

# run <script> <x1 y1 x2 y2 ..>

from collections import Counter
import sys

def sqDist(coords):
    return (coords[2]-coords[0])**2 + (coords[3]-coords[1])**2

def sqDistHash(coords):
    return Counter([sqDist([coords[ix] for ix in [2*i,2*i+1,2*j,2*j+1]]) for i in range(3) for j in range(i+1,4)])

def isSq(coords):
    return sorted(dict(sqDistHash(coords)).values()) == [2,4]

print(1 if isSq([float(x) for x in sys.argv[1:9]]) else 0)
