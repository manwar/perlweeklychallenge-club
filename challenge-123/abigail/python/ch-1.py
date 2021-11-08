#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

ugly   = [1]
next_2 =  0
next_3 =  0
next_5 =  0


for n in fileinput . input ():
    n = int (n)
    while len (ugly) < n:
        ugly . append (min ([2 * ugly [next_2],
                             3 * ugly [next_3],
                             5 * ugly [next_5]]))

        if 2 * ugly [next_2] <= ugly [-1]:
            next_2 = next_2 + 1
        if 3 * ugly [next_3] <= ugly [-1]:
            next_3 = next_3 + 1
        if 5 * ugly [next_5] <= ugly [-1]:
            next_5 = next_5 + 1

    print (ugly [n - 1])
