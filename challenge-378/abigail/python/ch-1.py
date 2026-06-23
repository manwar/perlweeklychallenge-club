#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    max = -1
    sec = -1
    for c in re . findall (r'[0-9]', line):
        ch = int (c)
        if   max < ch:
            sec = max
            max = ch
        elif max > ch and ch > sec:
            sec = ch
    print (sec)
