#!/opt/homebrew/bin/python3

import sys
import re

for line in sys.stdin:
    valid = 0
    for token in line . split ():
        if re . match (r'^(?:[a-z]+(?:-[a-z]+)?)?[!,.]?$', token):
            valid = valid + 1
    print (valid)
