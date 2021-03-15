#!/opt/local/bin/python

#
# See ../READ.md
#

#
# Run as python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    print int (line)
