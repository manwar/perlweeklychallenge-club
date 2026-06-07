#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    if not re . search ("^[a-h][1-8] [a-h][1-8]$", line):
        break

    p1 = (ord (line [0]) % 2) == (ord (line [1]) % 2)
    p2 = (ord (line [3]) % 2) == (ord (line [4]) % 2)

    if p1 and p2 or not p1 and not p2:
        print ("true")
    else:
        print ("false")
