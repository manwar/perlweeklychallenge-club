#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    num = int (line)
    print ( (num & 0x55) << 1
          | (num & 0xAA) >> 1)
