# Test run:
# $ python3 ch-1.py 100
# 13015

import sys, math

n = 3 if len(sys.argv) == 1 else int(sys.argv[1])

s = 0
for x in range(1, n + 1):
    for y in range(x + 1, n + 1):
        s += math.gcd(x, y)

print(s)
