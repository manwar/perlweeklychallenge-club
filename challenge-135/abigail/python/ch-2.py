#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
import re

w = [1, 3, 1, 7, 3, 9, 1]

for line in fileinput . input ():
    line = line . strip ()
    if re . search (r'^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$', line):
        check = 0
        for i in range (len (line)):
            val = ord (line [i : i + 1])
            if val <= ord ("9"):
                val = val - ord ("0")
            else:
                val = val - ord ("A") + 10
            check = check + w [i] * val
        if check % 10 == 0:
            print (1)
        else:
            print (0)
    else:
        print (0)
