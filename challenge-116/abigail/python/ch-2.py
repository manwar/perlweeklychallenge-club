#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput
from math import sqrt

for line in fileinput . input ():
    sum_of_squares = 0
    for char in line:
        if "1" <= char and char <= "9":
            sum_of_squares = sum_of_squares + int (char) * int (char)
    root = int (.5 + sqrt (sum_of_squares))
    if sum_of_squares == root * root:
        print (1)
    else:
        print (0)
