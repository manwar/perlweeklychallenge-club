
from itertools import combinations

def triplet(test):
    for comb in combinations(test, 3):
        if 1 < sum(comb) < 2:
            return 1
    
    return 0
    
tests = ([1.2, 0.4, 0.1, 2.5], [0.2, 1.5, 0.9, 1.1],
         [0.5, 1.1, 0.3, 0.7], [0.7, 4.3, -0.1, 1.1])
for test in tests:
    print(test, "  ", triplet(test))
    


