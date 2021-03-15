#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

def LevenshteinDistance (first, second):
    n = len (first)
    m = len (second)
    distance = []
    for i in range (n + 1):
        distance . append ([])
        for j in range (m + 1):
            distance [i] . append (i + j if i == 0 or j == 0 else
                         min (distance [i - 1] [j]     + 1,
                              distance [i]     [j - 1] + 1,
                              distance [i - 1] [j - 1] +
                                 (0 if first  [i - 1] ==
                                       second [j - 1] else 1)))
    return distance [n] [m]


for line in fileinput . input ():
    words = line . strip () . split ()
    print LevenshteinDistance (words [0], words [1])
