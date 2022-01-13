#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

def substrings (n, m, prefix, max):
    if len (n) == 0:
        if prefix > -1  and prefix < max and prefix % m == 0:
            return 1
        else:
            return 0

    fc   = int (n [0 : 1])
    tail = n [1:]
    if prefix == -1:
        n_prefix = fc
    else:
        n_prefix = 10 * prefix + fc

    return substrings (tail, m, n_prefix, max) + \
           substrings (tail, m,   prefix, max)

for line in fileinput . input ():
    n, m = line . strip () . split (" ")
    print (substrings (n, int (m), -1, int (n)))
