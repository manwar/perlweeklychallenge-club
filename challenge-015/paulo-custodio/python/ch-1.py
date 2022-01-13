#!/usr/bin/python3

# Challenge 015
#
# Task #1
# Write a script to generate first 10 strong and weak prime numbers.
#
#   For example, the nth prime number is represented by p(n).
#
#   p(1) = 2
#   p(2) = 3
#   p(3) = 5
#   p(4) = 7
#   p(5) = 11
#
#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

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

def prime_iter(strong):
    last = [1,2,3]       # 1 + first two primes; 1 is discarded on first iteration
    while True:
        # get next prime, drop oldest
        last.pop(0)
        last.append(next_prime(last[-1]))

        avg = (last[-3]+last[-1])/2
        if strong:
            if last[-2] > avg:
                yield last[-2]
        else:
            if last[-2] < avg:
                yield last[-2]

def primes_list(num, strong):
    result = []
    for p in prime_iter(strong):
        result.append(p)
        if len(result) >= num:
            return result

num = int(sys.argv[1])
print("Strong Prime: "+", ".join([str(x) for x in primes_list(num, True)]))
print("Weak Prime:   "+", ".join([str(x) for x in primes_list(num, False)]))
