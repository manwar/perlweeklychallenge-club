#!/usr/bin/env python3
"""
Perl Weekly Challenge 119 - Task 2: Sequence without 1-on-1

Generate the increasing sequence of integers that contain only digits 1, 2, and
3 and do not have any '11' substring. Given N, return the N-th term.

Examples:
  N=5  -> 13
  N=10 -> 32
  N=60 -> 2223
"""

from __future__ import annotations

from typing import Sequence


def nth_term(n: int) -> int:
    """Return the n-th term (1-indexed) of the sequence."""
    if n < 1:
        raise ValueError("n must be positive")

    count = 0
    x = 0
    while count < n:
        x += 1
        s = str(x)
        if any(ch in "0456789" for ch in s):
            continue
        if "11" in s:
            continue
        count += 1
    return x


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(nth_term(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge119Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(nth_term(5), 13)

        def test_example_2(self) -> None:
            self.assertEqual(nth_term(10), 32)

        def test_example_3(self) -> None:
            self.assertEqual(nth_term(60), 2223)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge119Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

