#!/usr/bin/env python3
"""
Perl Weekly Challenge 123 - Task 1: Ugly Numbers

Ugly numbers are positive numbers whose prime factors are limited to 2, 3 and 5
only. Given n >= 1, return the n-th ugly number.
"""

from __future__ import annotations

from typing import Sequence


def nth_ugly(n: int) -> int:
    """Return the n-th ugly number."""
    if n < 1:
        raise ValueError("n must be >= 1")

    ugly: list[int] = [1]
    i2 = i3 = i5 = 0
    next2, next3, next5 = 2, 3, 5

    while len(ugly) < n:
        nxt = min(next2, next3, next5)
        ugly.append(nxt)

        if nxt == next2:
            i2 += 1
            next2 = ugly[i2] * 2
        if nxt == next3:
            i3 += 1
            next3 = ugly[i3] * 3
        if nxt == next5:
            i5 += 1
            next5 = ugly[i5] * 5

    return ugly[-1]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <n>")
    print(nth_ugly(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge123Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(nth_ugly(7), 8)

        def test_example_2(self) -> None:
            self.assertEqual(nth_ugly(10), 12)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge123Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

