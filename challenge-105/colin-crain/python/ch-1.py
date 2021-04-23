#!/usr/bin/env python3
#
#
#       nth-root.py
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

import math

def nroot( n, x ):
    return math.exp( math.log(x) / n )

m = 3
y = 125

print( nroot(m, y) )

