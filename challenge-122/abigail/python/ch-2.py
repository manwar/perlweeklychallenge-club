#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import sys

n = int (sys . stdin . readline ())

scores = [[], [], [""]]

for i in range (n):
    new = []
    for j in range (3):
        for k in scores [len (scores) - 1 - j]:
            new . append (str (j + 1) + " " + k)
    scores . append (new)

for score in scores [-1]:
    print (score)
