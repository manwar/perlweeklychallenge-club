#!/usr/bin/env python3
"""Perl Weekly Challenge 076 - Task 1: Prime Sum.

Find the minimum number of prime numbers required whose summation gives N.
"""

from __future__ import annotations

import unittest


def is_prime(n: int) -> bool:
    """Determine whether an integer n is prime.

    :param n: Integer to test.
    :return: True if n is prime, False otherwise.
    """
    if n < 2:
        return False
    if n in (2, 3):
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False

    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True


def get_nr_primes(n: int) -> int:
    """Calculate the minimum number of prime numbers required to sum to n.

    Based on Goldbach's conjecture:
    - If n is prime: 1 prime
    - If n is even (n > 2): 2 primes
    - If n is odd: 2 primes if (n - 2) is prime, else 3 primes.

    :param n: Input integer.
    :return: Minimum count of prime summands.
    """
    if n < 2:
        return 0

    if is_prime(n):
        return 1

    if n % 2 == 0:
        return 2

    if is_prime(n - 2):
        return 2

    return 3


class TestPrimeSum(unittest.TestCase):
    """Test cases for get_nr_primes."""

    def test_example_2(self) -> None:
        self.assertEqual(get_nr_primes(2), 1)

    def test_example_9(self) -> None:
        self.assertEqual(get_nr_primes(9), 2)

    def test_example_10(self) -> None:
        self.assertEqual(get_nr_primes(10), 2)

    def test_example_12(self) -> None:
        self.assertEqual(get_nr_primes(12), 2)

    def test_example_27(self) -> None:
        self.assertEqual(get_nr_primes(27), 3)


if __name__ == "__main__":
    unittest.main()
