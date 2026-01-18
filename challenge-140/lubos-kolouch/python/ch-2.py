#!/usr/bin/env python3
"""
Perl Weekly Challenge 140 - Task 2: Multiplication Table

You are given three positive integers i, j and k.
Print the k-th element in the sorted multiplication table of i and j.
"""

from __future__ import annotations

from typing import Sequence


def kth_multiplication_table(i: int, j: int, k: int) -> int:
    """Return the k-th smallest value in the i-by-j multiplication table."""
    if i <= 0 or j <= 0 or k <= 0:
        raise ValueError("i, j and k must be positive integers")
    if k > i * j:
        raise ValueError("k must be within the multiplication table size")

    rows, cols = (i, j) if i <= j else (j, i)

    def count_le(x: int) -> int:
        # Count values <= x in the multiplication table.
        return sum(min(cols, x // r) for r in range(1, rows + 1))

    lo, hi = 1, i * j
    while lo < hi:
        mid = (lo + hi) // 2
        if count_le(mid) >= k:
            hi = mid
        else:
            lo = mid + 1
    return lo


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 3:
        raise SystemExit(f"Usage: {__file__} <i> <j> <k>")

    i = int(argv[0])
    j = int(argv[1])
    k = int(argv[2])
    print(kth_multiplication_table(i, j, k))


def _run_tests() -> None:
    import unittest

    class TestChallenge140Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(kth_multiplication_table(2, 3, 4), 3)

        def test_example_2(self) -> None:
            self.assertEqual(kth_multiplication_table(3, 3, 6), 4)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge140Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

