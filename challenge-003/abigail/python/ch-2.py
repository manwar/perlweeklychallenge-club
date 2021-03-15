#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-2.py < input-file
#

import fileinput
import sys

#
# Iterate over the input
#
for line in fileinput . input ():
    rows = int (line)

    #
    # Create the first row, and print it
    #
    row = [1]
    sys . stdout . write (str (1) + "\n")

    for r in range (1, rows + 1):
        #
        # Create a new row
        #
        new = [None] * (r + 1)   # In Python, arrays don't grow automatically
        for i in range (r + 1):
            sum = 0
            if i > 0:
                sum = row [i - 1]
                sys . stdout . write (" ")
            if i < r:
                sum = sum + row [i]
            new [i] = sum
            sys . stdout . write (str (sum))
        sys . stdout . write ("\n")

        #
        # New row becomes current row
        #
        row = new

