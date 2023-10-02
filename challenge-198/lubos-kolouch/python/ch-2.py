#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from math import sqrt


def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(sqrt(num)) + 1):
        if num % i == 0:
            return False
    return True


def prime_count(n):
    return sum(1 for i in range(1, n) if is_prime(i))


class TestPrimeCount(unittest.TestCase):

    def test_cases(self):
        self.assertEqual(prime_count(10), 4, 'Test Case 1')
        self.assertEqual(prime_count(15), 6, 'Test Case 2')
        self.assertEqual(prime_count(1), 0, 'Test Case 3')
        self.assertEqual(prime_count(25), 9, 'Test Case 4')


if __name__ == '__main__':
    unittest.main()
