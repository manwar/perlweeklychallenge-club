#!/usr/bin/env python3
"""
Perl Weekly Challenge 098 - Task 2: Search Insert Position

You are given a sorted array of distinct integers N and a target value.

Return the index of the target if found; otherwise return the index where the
target should be inserted to keep the array sorted.
"""

from __future__ import annotations

from typing import Sequence


def search_insert_position(nums: Sequence[int], target: int) -> int:
    """Return the index where `target` is (or should be) in sorted `nums`."""
    lo = 0
    hi = len(nums)
    while lo < hi:
        mid = (lo + hi) // 2
        if nums[mid] < target:
            lo = mid + 1
        else:
            hi = mid
    return lo


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge098Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(search_insert_position([1, 2, 3, 4], 3), 2)

        def test_example_2(self) -> None:
            self.assertEqual(search_insert_position([1, 3, 5, 7], 6), 3)

        def test_example_3(self) -> None:
            self.assertEqual(search_insert_position([12, 14, 16, 18], 10), 0)

        def test_example_4(self) -> None:
            self.assertEqual(search_insert_position([11, 13, 15, 17], 19), 4)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge098Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

