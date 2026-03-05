#!/usr/bin/env python3

import sys

ints = [int(x) for x in sys.argv[1:]]
count = {}
for x in ints:
    if x in count:
        count[x] += 1
    else:
        count[x] = 1
unique = list(filter(lambda x:count[x]==1, ints))
if len(unique) == 0:
    print(-1)
else:
    print(unique[0])
