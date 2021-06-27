#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    bin = '{:b}' . format (int (line))     # Turn to binary representation
    if bin == bin [::-1]:                  # bin [::-1] reverse the string
        print (1)
    else:
        print (0)

