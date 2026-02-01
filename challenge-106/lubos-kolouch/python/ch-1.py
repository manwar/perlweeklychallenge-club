#!/usr/bin/env python3
"""
Perl Weekly Challenge 106 - Task 1: Maximum Gap

Given an array of integers, find the maximum difference between two successive
elements after sorting.
If the array contains only 1 element then the result is 0.
"""

from __future__ import annotations

from typing import Sequence


def maximum_gap(values: Sequence[int]) -> int:
    if len(values) <= 1:
        return 0
    s = sorted(values)
    return max(s[i + 1] - s[i] for i in range(len(s) - 1))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge106Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(maximum_gap([2, 9, 3, 5]), 4)

        def test_example_2(self) -> None:
            self.assertEqual(maximum_gap([1, 3, 8, 2, 0]), 5)

        def test_example_3(self) -> None:
            self.assertEqual(maximum_gap([5]), 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge106Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

