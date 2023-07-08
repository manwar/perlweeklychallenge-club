#!/usr/bin/env python
# -*- coding: utf-8 -*-


def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True


def generate_semiprimes(n):
    primes = [i for i in range(2, n + 1) if is_prime(i)]
    semiprimes = set()

    for i in range(len(primes)):
        for j in range(i, len(primes)):
            semiprime = primes[i] * primes[j]
            if semiprime <= n:
                semiprimes.add(semiprime)

    return sorted(list(semiprimes))


print(generate_semiprimes(100))
