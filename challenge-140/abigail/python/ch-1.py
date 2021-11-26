#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    a, b = line . strip () . split (" ")
    print (bin (int (a, 2) + int (b, 2)) [2:])
