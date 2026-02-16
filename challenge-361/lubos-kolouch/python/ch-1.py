#!/usr/bin/env python3
"""
Perl Weekly Challenge 361 - Task 1: Zeckendorf Representation

Given a positive integer (<= 100), return the Zeckendorf representation:
every positive integer can be uniquely represented as the sum of non-consecutive
Fibonacci numbers.

We use Fibonacci numbers starting with 1, 2 (i.e. 1, 2, 3, 5, 8, ...), matching
the provided examples.
"""

from __future__ import annotations

from typing import List, Sequence


def zeckendorf(n: int) -> List[int]:
    """Return Zeckendorf representation parts in descending order."""
    if n < 1 or n > 100:
        raise ValueError("n must be in the range 1..100")

    fibs = [1, 2]
    while fibs[-1] + fibs[-2] <= n:
        fibs.append(fibs[-1] + fibs[-2])

    parts: List[int] = []
    remaining = n
    i = len(fibs) - 1
    while remaining > 0:
        if fibs[i] <= remaining:
            parts.append(fibs[i])
            remaining -= fibs[i]
            i -= 2
        else:
            i -= 1
    return parts


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <int>")
    print(",".join(str(x) for x in zeckendorf(int(argv[0]))))


def _run_tests() -> None:
    import unittest

    class TestChallenge361Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(zeckendorf(4), [3, 1])

        def test_example_2(self) -> None:
            self.assertEqual(zeckendorf(12), [8, 3, 1])

        def test_example_3(self) -> None:
            self.assertEqual(zeckendorf(20), [13, 5, 2])

        def test_example_4(self) -> None:
            self.assertEqual(zeckendorf(96), [89, 5, 2])

        def test_example_5(self) -> None:
            self.assertEqual(zeckendorf(100), [89, 8, 3])

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge361Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

