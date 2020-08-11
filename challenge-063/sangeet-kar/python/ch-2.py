#!/usr/bin/env python

import sys
from itertools import count

def rot(string, n=1):
    return string[n:] + string[:n]

inp = sys.argv[1] if len(sys.argv) > 1 else 'xyxx'

tmp = inp
for i in count(1):
    tmp = rot(tmp, i % len(inp))
    if tmp == inp:
        print(i)
        break
