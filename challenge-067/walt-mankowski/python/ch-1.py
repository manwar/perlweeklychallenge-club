from sys import argv
from itertools import combinations

m, n = [int(x) for x in argv[1:]]
it = combinations(range(1,m+1), n)
combs = [comb for comb in it]
print(combs)
