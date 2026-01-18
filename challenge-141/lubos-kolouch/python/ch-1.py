#!/usr/bin/env python3
"""
Perl Weekly Challenge 141 - Task 1: Number Divisors

Find the lowest N positive integers having exactly 8 divisors.

The challenge statement provides the example that 24 has exactly 8 divisors:
1, 2, 3, 4, 6, 8, 12 and 24.
"""

from __future__ import annotations

from typing import List, Sequence


def divisors(n: int) -> List[int]:
    """Return all positive divisors of n, sorted ascending."""
    if n <= 0:
        raise ValueError("n must be a positive integer")

    small: List[int] = []
    large: List[int] = []

    d = 1
    while d * d <= n:
        if n % d == 0:
            small.append(d)
            other = n // d
            if other != d:
                large.append(other)
        d += 1

    return small + list(reversed(large))


def first_numbers_with_divisor_count(count: int, divisor_count: int) -> List[int]:
    """Return the first `count` positive integers with exactly `divisor_count` divisors."""
    if count <= 0:
        raise ValueError("count must be positive")
    if divisor_count <= 0:
        raise ValueError("divisor_count must be positive")

    out: List[int] = []
    x = 1
    while len(out) < count:
        if len(divisors(x)) == divisor_count:
            out.append(x)
        x += 1
    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} [N]")

    n = int(argv[0])
    result = first_numbers_with_divisor_count(n, 8)
    print(", ".join(map(str, result)))


def _run_tests() -> None:
    import unittest

    class TestChallenge141Task1(unittest.TestCase):
        def test_example_24_divisors(self) -> None:
            self.assertEqual(divisors(24), [1, 2, 3, 4, 6, 8, 12, 24])

        def test_first_10_have_8_divisors(self) -> None:
            nums = first_numbers_with_divisor_count(10, 8)
            self.assertEqual(nums[0], 24)
            self.assertEqual(len(nums), 10)
            self.assertTrue(all(len(divisors(x)) == 8 for x in nums))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge141Task1)
    runner = unittest.TextTestRunner()
    result = runner.run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
