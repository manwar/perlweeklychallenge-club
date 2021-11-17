#!/usr/bin/python3

# Challenge 012
#
# Challenge #1
# The numbers formed by adding one to the products of the smallest primes are
# called the Euclid Numbers (see wiki). Write a script that finds the smallest
# Euclid Number that is not prime. This challenge was proposed by
# Laurent Rosenfeld.

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

def euclid_iter():
    prime = 1
    prime_prod = 1
    while True:
        prime = next_prime(prime)
        prime_prod *= prime
        yield prime_prod+1

for n in euclid_iter():
    if primes.check(n):
        pass
    else:
        print(n)
        break
