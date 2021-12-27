#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py
#

import math

count          = 10
nr_of_divisors =  8

n = 0
while count > 0:
    n = n + 1
    s = math . floor (math . sqrt (n))
    if n == s * s:
        continue
    c = 0
    for d in range (1, s + 1):
        if n % d == 0:
            c = c + 2
            if c > nr_of_divisors:
                break
    if c == nr_of_divisors:
        print (n)
        count = count - 1
