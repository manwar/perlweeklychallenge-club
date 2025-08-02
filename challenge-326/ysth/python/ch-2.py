import sys
from itertools import repeat, batched

ints = [ int(i) for i in sys.argv[1:] ];

print([n for ij in batched(ints, n=2) for n in repeat(ij[1], ij[0])])
