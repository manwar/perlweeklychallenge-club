#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    list = line . split (" ")
    sorted = 1
    for i in range (1, len (list)):
        if list [i - 1] > list [i]:
            sorted = 0
    print (sorted)
