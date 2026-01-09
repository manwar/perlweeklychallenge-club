#!/usr/bin/env python3
"""Penny Piles - Perl Weekly Challenge 201 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def penny_piles(n: int) -> int:
    """Return number of integer partitions of n (n > 0)."""
    if n <= 0:
        raise ValueError("Expected n > 0")

    dp = [0] * (n + 1)
    dp[0] = 1
    for k in range(1, n + 1):
        for i in range(k, n + 1):
            dp[i] += dp[i - k]
    return dp[n]


class PennyPilesExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example(self) -> None:
        self.assertEqual(penny_piles(5), 7)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <n>")
    n = int(args[0])
    print(f"Input:  $n = {n}")
    print(f"Output: {penny_piles(n)}")


if __name__ == "__main__":
    main()

