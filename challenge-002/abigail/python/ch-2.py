#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-2.py {-f | -t} < input-file
#

import fileinput
import sys
import getopt

BASE = 35

#
# Parse options
#
do_to_base   = 0
do_from_base = 0
opts, args = getopt . getopt (sys . argv [1:], 'ft')

for opt, val in opts:
    if   opt == "-f":
        do_from_base = 1
    elif opt == "-t":
        do_to_base = 1

if do_to_base + do_from_base != 1:
    print "Need exactly one of -f or -t"
    sys . exit (1)


#
# Translate a base 10 number to base 35
#
def to_base (number):
    out = ""
    while number > 0:
        rest = number % BASE
        if rest < 10:
            char = str (rest)
        else:
            char = chr (65 + rest - 10)
        out = char + out
        number = int (number / BASE)
    return out


#
# Translate a number from base BASE to base 10
#
def from_base (number):
    return int (number, BASE)
    
#
# Need to clean argv, else fileinput will try to open a file
#
sys . argv [1:] = []

for line in fileinput . input ():
    print from_base (line) if do_from_base else to_base (int (line))
