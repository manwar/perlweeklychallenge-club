#!/usr/bin/env python
# -*- coding: utf-8 -*-


def nth_prime(n):
    primes = [2]
    i = 3
    while len(primes) < n:
        if all(i % p > 0 for p in primes):
            primes.append(i)
        i += 2
    return primes[-1]


print(nth_prime(10001))  # Output: 104743
