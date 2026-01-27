#!/usr/bin/env python3
"""
Perl Weekly Challenge 126 - Task 1: Count Numbers

Given a positive integer N, print the count of numbers from 1 to N that don't
contain digit '1'.
"""

from __future__ import annotations

from typing import Sequence


def count_without_digit_one(n: int) -> int:
    """Return count of integers in [1..n] whose decimal representation has no '1'."""
    if n < 1:
        raise ValueError("n must be a positive integer")
    return sum(1 for x in range(1, n + 1) if "1" not in str(x))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(count_without_digit_one(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge126Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(count_without_digit_one(15), 8)

        def test_example_2(self) -> None:
            self.assertEqual(count_without_digit_one(25), 13)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge126Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

