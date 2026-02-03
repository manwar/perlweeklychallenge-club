#!/usr/bin/env python3
"""
Perl Weekly Challenge 105 - Task 1: Nth root

You are given positive numbers N and k.
Return the Nth root of k (rounded to 2 decimals), matching the examples.
"""

from __future__ import annotations

from typing import Sequence


def nth_root(n: int, k: float) -> str:
    """Return the Nth root of k, rounded to 2 decimals, without trailing zeros."""
    if n <= 0 or k <= 0:
        raise ValueError("n and k must be positive")
    value = k ** (1.0 / n)
    s = f"{value:.2f}".rstrip("0").rstrip(".")
    return s


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <N> <k>")
    print(nth_root(int(argv[0]), float(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge105Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(nth_root(5, 248832), "12")

        def test_example_2(self) -> None:
            self.assertEqual(nth_root(5, 34), "2.02")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge105Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

