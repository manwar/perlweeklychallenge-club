#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    #
    # Extract the numbers from the line of input, by splitting
    # the input on white space, and forcing the chucks to be integer.
    #
    N = list (map (lambda x: int (x), line . split ()))

    #
    # sort () modifies the array
    #
    N . sort ()

    #
    # Find the maximum difference
    #
    max = 0
    for i in range (1, len (N)):
        if N [i] - N [i - 1] > max:
            max = N [i] - N [i - 1]

    #
    # Print it
    #
    print (max)
