import sys
from itertools import pairwise

ints = [ int(i) for i in sys.argv[1:] ]

ints.sort()

min_difference = None
pair_starts = []

for x,y in pairwise(ints):
    if min_difference is None or y - x < min_difference:
        min_difference = y - x
        pair_starts = [x]
    elif y - x == min_difference:
        pair_starts.append(x)

for i in pair_starts:
    print([i, i + min_difference])
