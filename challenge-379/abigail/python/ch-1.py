#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    rev = ""
    for ch in line . strip ():
        rev = ch + rev
    print (rev)
