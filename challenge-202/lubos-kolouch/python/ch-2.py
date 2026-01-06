#!/usr/bin/env python3
"""Widest Valley - Perl Weekly Challenge 202 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def widest_valley(profile: Sequence[int]) -> list[int]:
    """Return the leftmost widest valley.

    A valley is a subarray that is non-increasing then non-decreasing.
    """
    n = len(profile)
    if n == 0:
        return []

    left_start = [0] * n
    for i in range(1, n):
        left_start[i] = left_start[i - 1] if profile[i - 1] >= profile[i] else i

    right_end = [0] * n
    right_end[n - 1] = n - 1
    for i in range(n - 2, -1, -1):
        right_end[i] = right_end[i + 1] if profile[i] <= profile[i + 1] else i

    best_l, best_r, best_len = 0, 0, 1
    for p in range(n):
        l = left_start[p]
        r = right_end[p]
        length = r - l + 1
        if length > best_len or (length == best_len and l < best_l):
            best_l, best_r, best_len = l, r, length

    return list(profile[best_l : best_r + 1])


class WidestValleyExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(widest_valley((1, 5, 5, 2, 8)), [5, 5, 2, 8])

    def test_example_2(self) -> None:
        self.assertEqual(widest_valley((2, 6, 8, 5)), [2, 6, 8])

    def test_example_3(self) -> None:
        self.assertEqual(widest_valley((9, 8, 13, 13, 2, 2, 15, 17)), [13, 13, 2, 2, 15, 17])

    def test_example_4(self) -> None:
        self.assertEqual(widest_valley((2, 1, 2, 1, 3)), [2, 1, 2])

    def test_example_5(self) -> None:
        self.assertEqual(widest_valley((1, 3, 3, 2, 1, 2, 3, 3, 2)), [3, 3, 2, 1, 2, 3, 3])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    profile = [int(token) for token in args]
    out = widest_valley(profile)
    print(f"Input:  {', '.join(str(x) for x in profile)}")
    print(f"Output: {', '.join(str(x) for x in out)}")


if __name__ == "__main__":
    main()

