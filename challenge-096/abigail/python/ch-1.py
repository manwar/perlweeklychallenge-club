#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    words = line . strip () . split ()
    words . reverse ()
    print (" " . join (words))
