#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

s = 0
c = 0

for n in fileinput . input ():
    s = s + int (n)
    c = c + 1
    print (s // c)
