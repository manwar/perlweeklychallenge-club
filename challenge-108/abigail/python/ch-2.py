#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py
#

import sys

COUNT   = 10
PLAIN   =  0
COMPUTE =  1

type = PLAIN

if len (sys . argv) > 1 and sys . argv [1] == "compute":
    type = COMPUTE


if type == PLAIN:
    print ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147")


if type == COMPUTE:
    bell = [[1]]
    for x in range (1, COUNT - 1):
        bell . append ([bell [x - 1] [x - 1]])
        for y in range (1, x + 1):
            bell [x] . append (bell [x] [y - 1] + bell [x - 1] [y - 1])

    print (1, end = '')
    for x in range (0, COUNT - 1):
        print (",", bell [x] [x], end = '')

    print ("")
