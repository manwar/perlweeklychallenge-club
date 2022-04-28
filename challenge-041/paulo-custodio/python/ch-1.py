#!/usr/bin/env python3

# Challenge 041
#
# TASK #1
# Write a script to display attractive number between 1 and 50.
# A number is an attractive number if the number of its prime factors is also
# prime number.
#
# The number 20 is an attractive number, whose prime factors are 2, 2 and 5.
# The total prime factors is 3 which is also a prime number.

from primePy import primes

def is_attractive(n):
    factors = primes.factors(n)
    num_factors = len(factors)
    return num_factors != 1 and primes.check(num_factors)

out = []
for n in range(1, 50+1):
    if is_attractive(n):
        out.append(n)
print(", ".join([str(x) for x in out]))
