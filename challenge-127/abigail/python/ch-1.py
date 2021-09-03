#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import re

for line in fileinput . input ():
    seen = {}
    out  = 1
    for number in re . findall (r"[-+]?[0-9]+", line):
        if number in seen:
            out = 0
        seen [number] = 1
    print (out)
