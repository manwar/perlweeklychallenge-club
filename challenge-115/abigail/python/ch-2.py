#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

NR_OF_DIGITS = 10

for line in fileinput . input ():
    #
    # Parse the input, count digits
    #
    digits = []
    for d in range (NR_OF_DIGITS):
        digits . append (0)
    for d in line . split ():
        d = int (d)
        digits [d] = digits [d] + 1

    #
    # Find the smallest even number
    #
    last = -1

    for d in range (NR_OF_DIGITS - 2, -1, -2):
        if digits [d] > 0:
            last = d

    #
    # If we don't have an even number, skip
    #
    if last < 0:
        continue
    digits [last] = digits [last] - 1

    #
    # Print the rest of the digits, highest to lowest
    #
    for d in range (NR_OF_DIGITS - 1, 0, -1):
        for i in range (digits [d]):
            print (d, end = '')

    print (last)
