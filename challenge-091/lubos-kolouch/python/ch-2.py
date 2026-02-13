#!/usr/bin/env python3
"""
Perl Weekly Challenge 091 - Task 2: Jump Game

Given an array of positive numbers N, where the value at each index represents
the maximum jump length from that index, determine if you can reach the last
index. Return 1 if reachable, else 0.
"""

from __future__ import annotations

from typing import Sequence


def can_reach_last(nums: Sequence[int]) -> int:
    """Return 1 if the last index is reachable, else 0."""
    max_reach = 0
    for i, step in enumerate(nums):
        if i > max_reach:
            return 0
        max_reach = max(max_reach, i + step)
        if max_reach >= len(nums) - 1:
            return 1
    return 1


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge091Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(can_reach_last([1, 2, 1, 2]), 1)

        def test_example_2(self) -> None:
            self.assertEqual(can_reach_last([2, 1, 1, 0, 2]), 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge091Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

