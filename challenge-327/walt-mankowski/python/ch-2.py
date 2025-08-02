from sys import argv
from itertools import combinations

min_dist = 1e300
pairs = []
elements = sorted(map(int, argv[1:]))

for i,j in combinations(range(len(elements)), 2):
    delta = abs(elements[i] - elements[j])
    if delta < min_dist:
        pairs = [[elements[i], elements[j]]]
        min_dist = delta
    elif delta == min_dist:
        pairs.append([elements[i], elements[j]])

print(pairs)
