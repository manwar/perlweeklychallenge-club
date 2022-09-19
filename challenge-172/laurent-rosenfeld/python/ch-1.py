import math
from itertools import combinations

def is_prime(n):
  if n == 2:
    return True
  if n == 0 or n == 1 or n % 2 == 0:
    return False
  p = 3
  sqrt_n = math.sqrt(n)
  while (p <= sqrt_n):
    if ((n % p) == 0):
      return False
    p += 2
  return True

def partition(m, n):
  primes = filter(is_prime, range (1, m))
  for combination in combinations(primes, n):
    if sum(combination) == m:
      print(m, n, ": ", combination)

partition(18, 2)
partition(19, 3)
partition(25, 2)
