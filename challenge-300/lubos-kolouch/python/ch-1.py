#!/usr/bin/env python3
"""Beautiful Arrangement - Perl Weekly Challenge 300 task 1."""

from __future__ import annotations

from collections.abc import Sequence
from functools import lru_cache
import sys
import unittest


def beautiful_arrangements(n: int) -> int:
    """Return number of beautiful arrangements for n."""
    if n <= 0:
        raise ValueError("Expected a positive integer")

    allowed: list[list[int]] = [
        [],
        *[
            [val for val in range(1, n + 1) if val % pos == 0 or pos % val == 0]
            for pos in range(1, n + 1)
        ],
    ]

    full_mask = (1 << n) - 1

    @lru_cache(maxsize=None)
    def dfs(pos: int, mask: int) -> int:
        if pos > n:
            return 1
        total = 0
        for val in allowed[pos]:
            bit = 1 << (val - 1)
            if mask & bit:
                total += dfs(pos + 1, mask ^ bit)
        return total

    return dfs(1, full_mask)


class BeautifulArrangementExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(beautiful_arrangements(2), 2)

    def test_example_2(self) -> None:
        self.assertEqual(beautiful_arrangements(1), 1)

    def test_example_3(self) -> None:
        self.assertEqual(beautiful_arrangements(10), 700)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <n>")
    n = int(args[0])
    print(f"Input: $n = {n}")
    print(f"Output: {beautiful_arrangements(n)}")


if __name__ == "__main__":
    main()
