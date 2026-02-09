#!/usr/bin/env python3
"""
Perl Weekly Challenge 099 - Task 2: Unique Subsequence

Given two strings S and T, count the number of distinct subsequences of S
(without reordering characters) that equal T.

This is the classic "distinct subsequences" dynamic programming problem.
"""

from __future__ import annotations

from typing import Sequence


def unique_subsequence_count(s: str, t: str) -> int:
    """Return the number of distinct subsequences of `s` that equal `t`."""
    m = len(t)
    dp = [0] * (m + 1)
    dp[0] = 1

    for ch in s:
        for j in range(m, 0, -1):
            if ch == t[j - 1]:
                dp[j] += dp[j - 1]

    return dp[m]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <S> <T>")
    print(unique_subsequence_count(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge099Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(unique_subsequence_count("littleit", "lit"), 5)

        def test_example_2(self) -> None:
            self.assertEqual(unique_subsequence_count("london", "lon"), 3)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge099Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

