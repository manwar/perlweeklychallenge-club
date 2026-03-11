#!/opt/homebrew/bin/python3

import sys
import re

def subnum (match):
    return chr (ord ('a') + int (match . group (1)) - 1)

for line in sys.stdin:
    line = re . sub (r'(1[0-9]|2[0-6])#', subnum, line)
    line = re . sub (r'([1-9])',          subnum, line)
    print (line, end = '')
