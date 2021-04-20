#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py [plain | compute]
#

import sys

COUNT   = 20
PLAIN   =  0
COMPUTE =  1

def divisor_sum (n):
    sum = 0
    for i in range (2, n / 2 + 1):
        if n % i == 0:
            sum = sum + i
    return (sum)

type = PLAIN

if len (sys . argv) > 1 and sys . argv [1] == "compute":
    type = COMPUTE


if type == PLAIN:
    print ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21")


if type == COMPUTE:
    for n in range (1, COUNT + 1):
        if n > 1:
            print (", ", end = '')
        print (divisor_sum (n), end = '')
    print ("")
