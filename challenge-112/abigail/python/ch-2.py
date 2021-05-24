#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
from math import sqrt

SQRT5 = sqrt (5)
PHI   = (1 + SQRT5) / 2

for line in fileinput . input ():
    print (round (pow (PHI, int (line) + 1) / SQRT5))
