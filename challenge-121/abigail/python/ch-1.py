#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    [m, n] = map (lambda _: int (_), line . rstrip () . split (" "))
    print (m ^ (1 << (n - 1)))
