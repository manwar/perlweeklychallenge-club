#!/usr/bin/env python3

# Challenge 008
#
# Challenge #1
# Write a script that computes the first five perfect numbers. A perfect number
# is an integer that is the sum of its positive proper divisors (all divisors
# except itself). Please check Wiki for more information. This challenge was
# proposed by Laurent Rosenfeld.

import sys

def is_prime(n):
    if n <= 1:
        return 0
    elif n <= 3:
        return 1
    elif n % 2 == 0 or n % 3 == 0:
        return 0
    else:
        for i in range(5, n+1, 6):
            if i*i>n:
                break
            if n % i == 0 or n % (i+2) == 0:
                return 0
        return 1

def next_prime(n):
    if n<=1:
        return 2
    n += 1
    while not is_prime(n):
        n += 1
    return n

# Euclid proved that 2^(p-1)*(2^p - 1) is an even perfect number
# whenever 2p - 1 is prime
def perfect_iter():
    p = 1
    while True:
        p = next_prime(p)
        f = (2**p)-1
        if is_prime(f):
            yield (2**(p-1))*f

count = int(sys.argv[1])
for n in perfect_iter():
    print(n)
    count -= 1
    if count<=0:
        break
