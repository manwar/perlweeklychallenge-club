#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

MATRIX_SIZE = 5

import fileinput
import re

#
# Read in the matrix
#
matrix = {}
for i in range (MATRIX_SIZE):
    for n in re . findall (r'-?[0-9]+', input ()):
        matrix [n] = 1

#
# For the rest of the input, check whether it's in the matrix
#
for line in fileinput . input ():
    if line . strip () in matrix:
        print ("1")
    else:
        print ("0")
