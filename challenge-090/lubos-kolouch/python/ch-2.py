#!/usr/bin/env python3
"""
Perl Weekly Challenge 090 - Task 2: Ethiopian Multiplication

Demonstrate Ethiopian multiplication for positive integers A and B.

Algorithm:
- While A > 0:
  - If A is odd, add B to the running total
  - A = floor(A / 2)
  - B = B * 2
"""

from __future__ import annotations

from typing import Sequence


def ethiopian_multiply(a: int, b: int) -> int:
    """Return the product of positive integers `a` and `b` using the algorithm."""
    if a <= 0 or b <= 0:
        raise ValueError("a and b must be positive integers")

    total = 0
    x = a
    y = b
    while x > 0:
        if x % 2 == 1:
            total += y
        x //= 2
        y *= 2
    return total


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <A> <B>")
    print(ethiopian_multiply(int(argv[0]), int(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge090Task2(unittest.TestCase):
        def test_existing_repo_case(self) -> None:
            self.assertEqual(ethiopian_multiply(14, 12), 168)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge090Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

