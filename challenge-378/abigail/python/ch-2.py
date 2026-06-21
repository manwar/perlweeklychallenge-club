#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    line = line . strip () . \
                  translate (str . maketrans ('abcdefghij', '0123456789'))
    [n1, n2, sum] = list (map (lambda x: int (x), line . split (" ")))
    if n1 + n2 == sum:
        print ("true")
    else:
        print ("false")
