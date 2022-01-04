#!/opt/local/bin/python

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    print int (line)
