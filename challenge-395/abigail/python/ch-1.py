#!/opt/homebrew/bin/python3

import sys, re

for line in sys . stdin:
    r1, i1, r2, i2 = list (map (lambda x: int(x),
                           re . findall (r'-?[0-9]+', line)))
    r = r1 * r2 - i1 * i2
    i = r1 * i2 + r2 * i1
    if i < 0:
        print (f'{r}+({i})i')
    else:
        print (f'{r}+{i}i')
