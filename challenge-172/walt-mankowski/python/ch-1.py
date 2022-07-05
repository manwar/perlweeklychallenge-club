import sys
from itertools import combinations
from primes import primes_to

m, n = [int(x) for x in sys.argv[1:]]
primes = primes_to(m)

for comb in combinations(primes, n):
    if sum(comb) == m:
        print(comb)

