#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import re

for line in fileinput . input ():
    plain = re . sub (r'\s+',             "",     line)  # Strip whitespace
    plain = re . sub (r'^\+',             "00",   plain) # Replace leading +
    plain = re . sub (r'^\([0-9][0-9]\)', "0000", plain) # Replace leading (NN)
    if re . search (r'^[0-9]{14}$', plain):              # Chech for 14 digits
        print (line, end = '')
