#!/opt/homebrew/bin/python3

import sys

def process (n, u, d, prefix):
    if d == n: print (prefix, end = ' ')
    if d <  u: process (n, u, d + 1, prefix + "D")
    if u <  n: process (n, u + 1, d, prefix + "U")

for n in sys . stdin:
    process (int (n), 0, 0, "")
    print ("")
