#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-2.py -s SIZE < input-file
#

import fileinput
import sys
import getopt

#
# Parse and validate options
#
size = -1
opts, args = getopt . getopt (sys . argv [1:], 's:')
for opt, val in opts:
    if opt == "-s":
        size = int (val)

sys . argv [1:] = []

if size < 0:
    sys . stderr . write ("Argument -s SIZE is required\n")
    sys . exit (1)

#
# Iterate over the input. For each position, count the number of 0s,
# and calculate the number of 1s. Sum the minimum of those numbers.
#
for line in fileinput . input ():
    sections = len (line) / size
    sum = 0
    for i in range (size):
        zeros = 0
        for j in range (sections):
            index = j * size + i
            if line [index : index + 1] == "0":
                zeros += 1
        ones = sections - zeros
        sum += min (zeros, ones)
    print (sum)
