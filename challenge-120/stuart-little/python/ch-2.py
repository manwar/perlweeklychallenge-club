#!/usr/bin/env python

# run <script> <time>

import sys

def angl(h,m):
    rawDiff = abs((h % 12)*30 + m/2 - m * 6)
    return min(rawDiff, 360-rawDiff)

print(angl(*[int(x) for x in sys.argv[1].split(':')]))
