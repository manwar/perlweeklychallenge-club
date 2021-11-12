#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import math

for num in fileinput . input ():
    print (math . floor (math . exp (math . log (int (num)) / 2)))
