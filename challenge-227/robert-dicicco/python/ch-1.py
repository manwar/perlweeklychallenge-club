#!/usr/bin/env python
'''
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-24
Challenge 227 Task 1 Friday 13th ( Python )
-------------------------------------
'''

from datetime import date
import sys

n = len(sys.argv)
if n == 1:
    print("Please select a year between 1753 and 9999")
    sys.exit(0)

year = int(sys.argv[1])
if year < 1753 or year > 9999:
    print("Please select a year between 1753 and 9999")
    sys.exit(0)

for month in range(1,12):
    d = date(year, month, 13)
    wd = d.weekday()
    if wd == 4:   # Monday = 0, Sunday = 6
        print(f"{year} {month} 13 is a Friday")
    month += 1

'''
-------------------------------------
SAMPLE OUTPUT
python .\Friday13.py 2023

2023 1 13 is a Friday
2023 10 13 is a Friday

python .\Friday13.py 1753

1753 4 13 is a Friday
1753 7 13 is a Friday
-------------------------------------
'''









