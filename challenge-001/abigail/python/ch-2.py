#!/opt/local/bin/python

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for max in fileinput . input ():
    for i in range (1, int (max) + 1):
        print ("fizzbuzz" if i % 15 == 0 else\
                   "buzz" if i %  5 == 0 else\
               "fizz"     if i %  3 == 0 else\
                i)
