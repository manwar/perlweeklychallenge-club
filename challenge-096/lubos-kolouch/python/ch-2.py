#!/usr/bin/env python3
"""
Perl Weekly Challenge 096 - Task 2: Edit Distance

You are given two strings S1 and S2.

Return the minimum number of operations required to convert S1 into S2, where
an operation is insert, remove, or replace a character.
"""

from __future__ import annotations

from typing import Sequence


def edit_distance(s1: str, s2: str) -> int:
    """Return the Levenshtein edit distance between `s1` and `s2`."""
    n = len(s1)
    m = len(s2)

    dp = [[0] * (m + 1) for _ in range(n + 1)]
    for i in range(1, n + 1):
        dp[i][0] = i
    for j in range(1, m + 1):
        dp[0][j] = j

    for i in range(1, n + 1):
        c1 = s1[i - 1]
        for j in range(1, m + 1):
            cost = 0 if c1 == s2[j - 1] else 1
            dp[i][j] = min(
                dp[i - 1][j] + 1,  # delete
                dp[i][j - 1] + 1,  # insert
                dp[i - 1][j - 1] + cost,  # replace
            )

    return dp[n][m]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <S1> <S2>")
    print(edit_distance(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge096Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(edit_distance("kitten", "sitting"), 3)

        def test_example_2(self) -> None:
            self.assertEqual(edit_distance("sunday", "monday"), 2)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge096Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

