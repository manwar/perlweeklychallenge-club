from sys import argv
from math import sqrt

def factors(n):
    s = set([1])
    for i in range(2, int(sqrt(n))+1) :
        if n % i == 0:
            s.add(i)
            s.add(n // i)
    return s

m, n = [int(x) for x in argv[1:]]
print(factors(m) & factors(n))
