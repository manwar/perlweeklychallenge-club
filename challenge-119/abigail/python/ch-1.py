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
    print ( (num & ~0xFF)
          | (num &  0x0F) << 4
          | (num &  0xF0) >> 4)
