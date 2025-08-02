#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_prime(n: int) -> bool:
    """Check if a number is prime."""
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True


def prime_sum(N: int) -> int:
    """Find the minimum number of prime numbers required whose summation gives N."""
    if N < 2:
        return 0
    if is_prime(N):
        return 1
    if N % 2 == 0:
        return 2  # Since N is even, it can be represented as the sum of two primes (Goldbach's conjecture)
    # For an odd N, check if N-2 is prime. If it is, then N can be expressed as the sum of 2 and N-2 (both primes)
    if is_prime(N - 2):
        return 2
    return 3  # If neither of the above conditions hold, N can be expressed as the sum of three primes


# Test the function with the example
assert prime_sum(9) == 2  # 2 + 7 = 9

prime_sum(9)
