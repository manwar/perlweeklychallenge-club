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
    line = re . sub (r'^[-+]', '', line . strip ())
    ll = len (line)
    if re . search (r'[^0-9]', line):
        print ("not an integer")
    elif ll % 2 == 0:
        print ("even number of digits")
    elif ll < 3:
        print ("too short")
    else:
        print (line [(ll - 3) // 2 : (ll + 3) // 2])
