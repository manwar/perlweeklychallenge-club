#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
import math

for line in fileinput . input ():
    i, j, k = map (lambda x: int (x), line . strip () . split (" "))
    n = 0
    while k > 0:
        n = n + 1
        s = math . floor (math . sqrt (n))
        for d in range (1, s + 1):
            if n % d == 0:
                if d <= i and n / d <= j: k = k - 1
                if d <= j and n / d <= i: k = k - 1
                if n == d * d:            k = k + 1
    print (n)
