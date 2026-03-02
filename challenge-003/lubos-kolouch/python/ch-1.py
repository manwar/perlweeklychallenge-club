#!/usr/bin/env python3

"""Perl Weekly Challenge 003 Task 1: 5-smooth numbers."""

from __future__ import annotations

from collections.abc import Sequence


def is_smooth(n: int) -> bool:
    """Return True if n is 5-smooth (prime factors are only 2, 3, 5)."""
    while n % 2 == 0:
        n //= 2
    while n % 3 == 0:
        n //= 3
    while n % 5 == 0:
        n //= 5
    return n == 1


def generate_smooth_numbers(n: int) -> list[int]:
    """Return first n 5-smooth numbers."""
    smooth_numbers = [1]
    candidate = 1
    while len(smooth_numbers) < n:
        candidate += 1
        if is_smooth(candidate):
            smooth_numbers.append(candidate)
    return smooth_numbers


def _run_tests() -> None:
    import unittest

    class TestSmoothNumbers(unittest.TestCase):
        def test_generate_smooth_numbers(self) -> None:
            expected = [1, 2, 3, 4, 5, 6, 8, 9, 10, 12]
            self.assertEqual(generate_smooth_numbers(10), expected)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestSmoothNumbers)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <count>")

    n = int(argv[0])
    smooth_numbers = generate_smooth_numbers(n)
    print(f"First {n} 5-smooth numbers:")
    print(", ".join(map(str, smooth_numbers)))


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
