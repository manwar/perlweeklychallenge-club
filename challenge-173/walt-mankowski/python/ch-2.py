#!/usr/bin/env python
from functools import reduce

sylvester = []
while len(sylvester) < 10:
    sylvester.append(reduce(lambda x,y: x*y, sylvester, 1) + 1)

for syl in sylvester:
    print(syl)
