#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import math
import fileinput

def _int (x):
    if x < 0:
        return math . ceil  (x)
    else:
        return math . floor (x)
        

def g2j (Y, M, D):
    return (int ((1461 * (Y +    4800 + int ((M - 14) / 12))) /   4) +
            int ((367 * (M - 2 -   12 * int ((M - 14) / 12))) /  12) -
            int ((3 * int (((Y + 4900 + int ((M - 14) / 12))  / 100))) / 4) +
            D - 32075)

def j2g (J):
    e  = 4 * (J + 1401 + int (int ((4 * J + 274277) / 146097) * 3 / 4) - 38) + 3
    D =   int (((5 * (int ((e % 1461) / 4)) + 2) % 153) / 5) + 1
    M = ((int  ((5 * (int ((e % 1461) / 4)) + 2) / 153) + 2) % 12) + 1
    Y = int (e / 1461) - 4716 + int ((12 + 2 - M) / 12)
    return Y, M, D

julian_today = g2j (2021, 9, 22)


for line in fileinput . input ():
    Y, M, D     = map (lambda x: int (x), line . strip () . split ("/"))
    julian_then = g2j (Y, M, D)
    Y1, M1, D1  = j2g (2 * julian_then  - julian_today)
    Y2, M2, D2  = j2g (2 * julian_today - julian_then)
    print ('{:04d}/{:02d}/{:02d}, {:04d}/{:02d}/{:02d}' . 
              format (Y1, M1, D1, Y2, M2, D2))
