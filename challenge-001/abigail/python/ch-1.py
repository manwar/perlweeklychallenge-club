#!/opt/local/bin/python

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-000
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    print (line . replace ("e", "E"), line . count ("e"))
