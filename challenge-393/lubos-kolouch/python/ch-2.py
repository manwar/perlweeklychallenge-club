#!/usr/bin/env python3
"""Perl Weekly Challenge 393 - Task 2: Prime Step.

What is the absolute difference of the sum of the ASCII values of
the characters in the string to the nearest prime number?
"""

import math
import unittest


def is_prime(n: int) -> bool:
    """Check if an integer n is prime.

    Args:
        n: Integer to test.

    Returns:
        True if n is prime, False otherwise.
    """
    if n < 2:
        return False
    if n in (2, 3):
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False

    limit = math.isqrt(n)
    for d in range(5, limit + 1, 6):
        if n % d == 0 or n % (d + 2) == 0:
            return False
    return True


def nearest_prime_diff(s: str) -> int:
    """Calculate absolute difference between ASCII sum of string and nearest prime.

    Args:
        s: Input alphabetic string.

    Returns:
        Absolute difference to the nearest prime.
    """
    total_ascii = sum(ord(ch) for ch in s)

    if is_prime(total_ascii):
        return 0

    diff = 1
    while True:
        if total_ascii - diff >= 2 and is_prime(total_ascii - diff):
            return diff
        if is_prime(total_ascii + diff):
            return diff
        diff += 1


class TestPrimeStep(unittest.TestCase):
    """Test suite for nearest_prime_diff."""

    def test_examples(self) -> None:
        """Test with challenge examples."""
        self.assertEqual(nearest_prime_diff("hello"), 9)
        self.assertEqual(nearest_prime_diff("football"), 2)
        self.assertEqual(nearest_prime_diff("a"), 0)
        self.assertEqual(nearest_prime_diff("challenge"), 2)
        self.assertEqual(nearest_prime_diff("perl"), 2)


if __name__ == "__main__":
    unittest.main()
