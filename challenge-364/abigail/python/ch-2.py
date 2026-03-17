#!/opt/homebrew/bin/python3

import sys

for line in sys.stdin:
    print (line . replace ("()",   "o") .
                  replace ("(al)", "al"), end = '')
