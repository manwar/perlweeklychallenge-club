#!/usr/bin/env python3
"""Ones and Zeroes - Perl Weekly Challenge 302 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def ones_and_zeroes(strs: Sequence[str], x: int, y: int) -> int:
    """Return max subset size with at most x zeros and y ones."""
    if x < 0 or y < 0:
        raise ValueError("Expected non-negative limits")

    dp = [[0] * (y + 1) for _ in range(x + 1)]
    for s in strs:
        if any(ch not in "01" for ch in s):
            raise ValueError("Expected binary strings")
        zeros = s.count("0")
        ones = len(s) - zeros
        for i in range(x, zeros - 1, -1):
            for j in range(y, ones - 1, -1):
                dp[i][j] = max(dp[i][j], dp[i - zeros][j - ones] + 1)
    return dp[x][y]


class OnesAndZeroesExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            ones_and_zeroes(("10", "0001", "111001", "1", "0"), 5, 3),
            4,
        )

    def test_example_2(self) -> None:
        self.assertEqual(ones_and_zeroes(("10", "1", "0"), 1, 1), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) < 3:
        raise SystemExit("Usage: python3 ch-1.py <x> <y> <bin1> [bin2...]")
    x = int(args[0])
    y = int(args[1])
    strs = args[2:]
    print(f"Output: {ones_and_zeroes(strs, x, y)}")


if __name__ == "__main__":
    main()
