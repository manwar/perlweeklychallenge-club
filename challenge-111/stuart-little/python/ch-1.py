#!/usr/bin/env python

# run <script>

import bisect
import itertools
import sys

def searchMatrix(needle,mat):
    flt = list(itertools.chain(*mat))
    i = bisect.bisect_left(flt, needle)
    if i != len(flt) and flt[i] == needle:
        return 1
    return 0

ar = [
    [  1,  2,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ],
]

print("Array:")
for row in ar:
    print(row)
print("")

toSearch=(1,35,39,100)
for x in toSearch:
    print(f"Found {x}?")
    print(searchMatrix(x,ar))
