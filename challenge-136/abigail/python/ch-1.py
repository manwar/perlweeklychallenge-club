#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import math

for line in fileinput . input ():
    m, n = line . strip () . split (' ')
    gcd = math . gcd (int (m), int (n))
    valid = 0
    if gcd > 1:
        while gcd % 2 == 0:
            gcd = gcd / 2
        if gcd == 1:
            valid = 1
    print (valid)
