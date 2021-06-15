#!/usr/bin/env python

# run <script> <number>

import sys

memo=[[''],['R','LH']]

def mkPaths(size):
    if size >= len(memo):
        res = ['R' + x for x in mkPaths(size-1)]
        res += ['L' + lft + 'H' + rght for nr in range(size) for lft in mkPaths(nr) for rght in mkPaths(size-1-nr)]
        memo.append(res)
    return memo[size]

for pth in mkPaths(int(sys.argv[1])):
    print(pth)
