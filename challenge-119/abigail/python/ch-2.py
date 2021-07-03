#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import re
import fileinput

def next_num (prev_num):
    match = re . match ('^(.*)([012])(3*)$', "0" + prev_num)
    return (re . sub ('^0', '',  \
                 re . sub ('11', '12', match . group (1) +                 \
                                       str (int (match . group (2)) + 1) + \
                                       re . sub ('3', '1', match . group (3)))))

for num in fileinput . input ():
    number = "0"
    for _ in range (int (num)):
        number = next_num (number)
    print (number)
