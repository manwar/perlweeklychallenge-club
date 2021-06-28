#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import sys

def steps (x, y, path):
    if x == 0 and y == 0:
        print (path)
        return
    if x > 0:
        steps (x - 1, y,     path + "R")
        steps (x - 1, y + 1, path + "L")
    if y > 0:
        steps (x,     y - 1, path + "H")


steps (int (sys . stdin . readline ()), 0, "")
