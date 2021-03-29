#!/usr/bin/env python

# run <script> <exponent> <number>

import itertools
import math
import sys

def nthRoot(xp,nr):
    rootFloor = next((i for i in itertools.count() if (i+1) ** xp > nr))
    if (rootFloor ** xp == nr):
        return rootFloor
    return math.exp(math.log(nr)/xp)

print(nthRoot(*list(map(lambda x: int(x),sys.argv[1:]))))
