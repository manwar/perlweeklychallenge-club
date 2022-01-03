#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
import sys

for line in fileinput . input ():
    a, b = map (lambda x: int (x), line . strip () . split ("/"))
    for i in range (2):
        if a < b:
            b = b - a
        else:
            a = a - b
        if a == 0 or b == 0:
            break
        sys . stdout . write ("{:}/{:} " . format (a, b))
    print ("")
