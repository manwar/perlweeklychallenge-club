#!/usr/bin/env python3
"""Unique Sum Zero - Perl Weekly Challenge 252 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def unique_sum_zero(n: int) -> list[int]:
    """Return a list of n unique integers that add up to zero."""
    if n < 0:
        raise ValueError("n must be non-negative")

    half = n // 2
    result: list[int] = []
    for i in range(1, half + 1):
        result.extend((i, -i))
    if n % 2 != 0:
        result.append(0)
    return result


class TestUniqueSumZero(unittest.TestCase):
    """Unit tests for unique_sum_zero."""

    def test_cases(self) -> None:
        """Test various values of n."""
        for n in (5, 3, 1, 4, 2):
            with self.subTest(n=n):
                res = unique_sum_zero(n)
                self.assertEqual(len(res), n)
                self.assertEqual(len(set(res)), n)
                self.assertEqual(sum(res), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        n = int(argv[1])
        print(f"Output: {unique_sum_zero(n)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
