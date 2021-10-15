#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    [n, m] = line . split ()
    seen = {}
    for i in range (int (n)):      #  0 .. (n - 1)
        for j in range (int (m)):  #  0 .. (m - 1)
            seen [(i + 1) * (j + 1)] = 1
    print (len (seen))
