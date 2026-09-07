#!/opt/homebrew/bin/python3

import sys, re

for line in sys . stdin:
    numbers = [int (x) for x in re . split (r'\s+', line . strip ())]
    pat = ""
    for index in range (1, len (numbers)):
        if numbers [index - 1] <  numbers [index]: pat = pat + "0"
        if numbers [index - 1] == numbers [index]: pat = pat + "1"
        if numbers [index - 1] >  numbers [index]: pat = pat + "2"
    max = 1
    for match in re . finditer (r'0?(?:20)*2?', pat):
        full_match = match . group (0)
        if len (full_match) >= max:
            max = 1 + len (full_match)
    print (max)
