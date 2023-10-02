#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sympy import isprime


def left_truncatable_primes(n):
    primes = []
    queue = list(map(str, range(1, 10)))  # we start from single-digit primes
    while len(primes) < n:
        num_str = queue.pop(0)
        if isprime(int(num_str)):
            primes.append(int(num_str))
            # adding digits to the end to try to form the next primes
            for i in range(10):
                queue.append(num_str + str(i))
    return primes[:n]


print(left_truncatable_primes(20))
