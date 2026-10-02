#!/usr/bin/env python3
"""Semi-Ordered Permutation - Perl Weekly Challenge 297 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def minimum_swaps(ints: Sequence[int]) -> int:
    """Calculate the minimum number of adjacent swaps to make the permutation semi-ordered."""
    n = len(ints)
    if n <= 1:
        return 0

    pos1 = ints.index(1)
    posn = ints.index(n)

    if pos1 < posn:
        return pos1 + (n - 1 - posn)
    return pos1 + (n - 1 - posn) - 1


class TestMinimumSwaps(unittest.TestCase):
    """Unit tests for minimum_swaps."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(minimum_swaps([2, 1, 4, 3]), 2)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(minimum_swaps([2, 4, 1, 3]), 3)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(minimum_swaps([1, 3, 2, 4, 5]), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
