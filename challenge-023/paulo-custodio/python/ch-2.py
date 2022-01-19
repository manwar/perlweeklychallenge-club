#!/usr/bin/python3

# Challenge 023
#
# Task #2
# Create a script that prints Prime Decomposition of a given number. The prime
# decomposition of a number is defined as a list of prime numbers which when
# all multiplied together, are equal to that number. For example, the Prime
# decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.

import sys
from primePy import primes

def next_prime(n):
    if n <= 1:
        return 2
    else:
        n += 1
        while not primes.check(n):
            n += 1
        return n

def prime_decomposition(n):
    if n<2:
        return [n]

    f = []
    p = 2
    while n>1:
        if n%p == 0:
            f.append(p)
            n //= p
        else:
            p = next_prime(p)
    return f

f = prime_decomposition(int(sys.argv[1]))
print(", ".join([str(x) for x in f]))
