#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#
# Input will consist of lines; each line will have two numbers, N and k, N > 0,
# k > 0. For each line of input, we output a line with the Nth root of k.
#
# We're not doing any input validations; we're assuming it's correct.
#

#
# To find the Nth root of a number k, we just raise k to the power 1/N
#

import fileinput

for line in fileinput . input ():
    N, k = line . split ()
    print (int (k) ** (1 / int (N)))
