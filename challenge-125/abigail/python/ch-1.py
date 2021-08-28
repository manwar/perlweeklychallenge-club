#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import math

def introot (square):
    return math . floor (.4 + math . sqrt (square))

for line in fileinput . input ():
    n = int (line)
    if n <= 2:
        print (-1)
        continue

    n_sq = n * n
    c    = n + 1
    c_sq = n_sq + 2 * n + 1
    while 2 * c - 1 <= n_sq:
        b_sq = c_sq - n_sq
        b    = introot (b_sq)

        if b_sq == b * b:
            print (str (n) + " " + str (b) + " " + str (c))

        c_sq = c_sq + 2 * c + 1
        c    = c + 1

    max_a = math . floor (n / math . sqrt (2))
    for a in range (3, max_a + 1):
        b_sq = n_sq - a * a
        b    = introot (b_sq)
        if b_sq == b * b:
            print (str (a) + " " + str (b) + " " + str (n))
