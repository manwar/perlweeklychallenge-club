#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-1.py -s SHIFT < input-file
#

import fileinput
import sys
import getopt

NR_OF_LETTERS = 26
ORD_A         = ord ("A")

#
# Parse and validate options
#
shift = -1
opts, args = getopt . getopt (sys . argv [1:], 's:')
for opt, val in opts:
    if opt == "-s":
        shift = int (val) % NR_OF_LETTERS

sys . argv [1:] = []

if shift < 0:
    sys . stderr . write ("Argument -s SHIFT is required\n")
    sys . exit (1)

#
# Iterate over the input. Shift capital letters
#
for line in fileinput . input ():
    out = ""
    for i in range (len (line)):
        if "A" <= line [i] <= "Z":
            n = ord (line [i]) - shift
            if n < ORD_A:
                n = n + NR_OF_LETTERS
            out += chr (n)
        else:
            out += line [i]
    sys . stdout . write (out)
