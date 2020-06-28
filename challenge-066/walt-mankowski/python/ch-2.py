from sys import argv
from math import log, sqrt, floor

# check if n is within EPS of being a whole number
def is_whole(n):
    EPS = 1e-10
    round = int(f'{n:.0f}')
    return abs(round - n) < EPS

# My algorithm is this:
#   Loop over all the m's from 2 to sqrt(N)
#   If m can be raised to an integer power to equal N, then log_m N is an integer

N = int(argv[1])
logn = log(N)
found = False
for m in range(2, int(sqrt(N))+1):
    n = logn / log(m)
    if is_whole(n):
        print(f'{m}^{n:.0f}')
        found = True

if not found:
    print(0)
