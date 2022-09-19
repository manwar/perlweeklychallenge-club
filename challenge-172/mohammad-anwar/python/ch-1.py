#!/usr/bin/python3

'''

Week 172:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-172

Task #1: Prime Partition

    You are given two positive integers, $m and $n.

    Write a script to find out the Prime Partition of the given
    number. No duplicates allowed.

'''

import math
import unittest
from itertools import combinations

def is_prime(n):
    if n == 1:
        return False

    i = 3
    while (i <= int(math.sqrt(n))):
        if ((n % i) == 0):
            return False
        i += 2

    return True

def prime_upto(m):
    primes = []
    i = 1
    while i <= m:
        i = i + 2
        if is_prime(i):
            primes.append(i)

    return primes

def prime_partition(m, n):
    primes = prime_upto(m)
    for combination in combinations(primes, n):
        if sum(combination) == m:
            return combination

#
#
# Unit test class

class TestPrimePartition(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(prime_partition(18, 2), (5, 13),    'Example 1')

    def test_example_2(self):
        self.assertEqual(prime_partition(19, 3), (3, 5, 11), 'Example 2')

unittest.main()
