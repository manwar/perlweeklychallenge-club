#!/usr/bin/env python3
"""
Perl Weekly Challenge 083 - Task 2: Flip Array

You are given an array of positive integers.

Flip the sign of some elements so that the resulting sum is minimum
non-negative (as close to zero as possible). Return the minimum number of
elements that need to be flipped to achieve that.
"""

from __future__ import annotations

from typing import List, Sequence


def min_flips(nums: Sequence[int]) -> int:
    """
    Return minimum number of flips achieving minimum non-negative sum.

    If we flip a subset with sum F, the resulting sum is S - 2F.
    We want S - 2F >= 0 and minimized, so maximize F with F <= S/2.
    Among those, minimize the subset size.
    """
    if any(n <= 0 for n in nums):
        raise ValueError("all elements must be positive integers")

    total = sum(nums)
    half = total // 2

    inf = 10**9
    dp: List[int] = [inf] * (half + 1)
    dp[0] = 0

    for v in nums:
        for s in range(half - v, -1, -1):
            if dp[s] != inf:
                dp[s + v] = min(dp[s + v], dp[s] + 1)

    best_sum = max(s for s in range(half + 1) if dp[s] != inf)
    return dp[best_sum]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge083Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(min_flips([3, 10, 8]), 1)

        def test_example_2(self) -> None:
            self.assertEqual(min_flips([12, 2, 10]), 1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge083Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

