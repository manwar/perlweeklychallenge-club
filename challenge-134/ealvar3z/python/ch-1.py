#!/usr/bin/env python

from itertools import permutations

ans = [int(''.join(d)) for d in permutations('0123456789', 10) if d[0] != '0']

print(ans[:5])
