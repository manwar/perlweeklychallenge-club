#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import sys

def steps (x, y, prefix):
    if x == 0 and y == 0:
        print (prefix)
        return
    if x > 0:
        steps (x - 1, y,     prefix + "R")
        steps (x - 1, y + 1, prefix + "L")
    if y > 0:
        steps (x,     y - 1, prefix + "H")


steps (int (sys . stdin . readline ()), 0, "")
